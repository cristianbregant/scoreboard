#!/bin/sh
# Builds the app icons of every platform from assets/app_icon/*.svg.
# macOS only: renders with Google Chrome, resizes with sips.
set -eu
cd "$(dirname "$0")/.."

chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

# Renders an SVG to a transparent 1024 px PNG.
render() {
  printf '<html><body style="margin:0;background:transparent">%s</body></html>' \
    "$(cat "$1")" > "$work/page.html"
  "$chrome" --headless=new --disable-gpu --hide-scrollbars \
    --default-background-color=00000000 --window-size=1024,1024 \
    --screenshot="$2" "file://$work/page.html" 2>/dev/null
}

render assets/app_icon/app_icon_macos.svg "$work/macos.png"
render assets/app_icon/app_icon.svg "$work/square.png"

# macOS
for size in 16 32 64 128 256 512 1024; do
  sips -z "$size" "$size" "$work/macos.png" \
    --out "macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_$size.png" >/dev/null
done

# Linux: the window icon, bundled as an asset.
sips -z 256 256 "$work/square.png" --out assets/app_icon/app_icon.png >/dev/null

# Windows: an .ico holding PNGs of each size.
for size in 16 24 32 48 64 128 256; do
  sips -z "$size" "$size" "$work/square.png" --out "$work/ico_$size.png" >/dev/null
done
python3 - "$work" windows/runner/resources/app_icon.ico <<'PY'
import struct, sys
work, out = sys.argv[1], sys.argv[2]
sizes = [16, 24, 32, 48, 64, 128, 256]
images = [open(f'{work}/ico_{s}.png', 'rb').read() for s in sizes]
offset = 6 + 16 * len(sizes)
header = struct.pack('<HHH', 0, 1, len(sizes))
entries = b''
for size, data in zip(sizes, images):
    side = 0 if size == 256 else size  # 0 means 256 in the ICO format
    entries += struct.pack('<BBBBHHII', side, side, 0, 0, 1, 32, len(data), offset)
    offset += len(data)
with open(out, 'wb') as f:
    f.write(header + entries + b''.join(images))
PY

echo "App icons updated."
