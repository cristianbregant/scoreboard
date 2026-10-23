# Scoreboard

A desktop app for workplace recognition, for macOS, Windows and Linux. Companies issue **verified achievements** to their people, and colleagues send each other lighter **base achievements**. Everything adds up to XP, levels and leaderboards. Achievements look like collectible cards: they tilt under the cursor and flip over to show who issued them.

![The achievements screen, with one verified card flipped to show the issuing company](docs/images/achievements.png)

## Features

- **Collectible cards.** Each achievement is a card with a 3D tilt, a light that follows the cursor and a back side.
  - Verified cards show the issuing company's logo, like a certificate.
  - Cards received from a colleague show the sender and their message.
- **Two kinds of achievements.**
  - *Verified*: issued only by the company. Worth up to 150 XP, ranked Bronze, Silver, Gold or Platinum.
  - *Base* (peer): created by anyone and sent between colleagues of the same company. Worth 10, 25 or 50 XP.
- **A shared library of base achievements.** Create your own with a name, description, icon and value, send them with an optional message, and see everything you sent.
- **Leaderboards.**
  - *Your company*: team ranking with a top-3 podium.
  - *Community*: everyone and every company, with search.
- **Profile.** Photo, cover (six patterns or your own image), bio, level progress and recent achievements.
- **Accounts.** Sign in, registration, email and password changes, sign out.
- **Light and dark themes**, with the choice remembered.

| | |
|---|---|
| ![Sign-in screen](docs/images/sign-in.png) | ![Achievement detail](docs/images/achievement-detail.png) |
| ![Base achievements library](docs/images/base-achievements.png) | ![Company leaderboard](docs/images/your-company.png) |
| ![Profile](docs/images/profile.png) | |

## Getting started

Requirements: Flutter 3.47 or newer (Dart 3.3+), plus the toolchain for your platform. Each platform builds only on its own OS.

| Platform | Toolchain |
|---|---|
| macOS | Xcode and CocoaPods (`brew install cocoapods`) |
| Windows | Visual Studio 2022 with the *Desktop development with C++* workload |
| Linux | `clang cmake ninja-build pkg-config libgtk-3-dev` (e.g. `sudo apt install …` on Debian/Ubuntu) |

```sh
flutter pub get
flutter run -d macos     # or: -d windows, -d linux
```

The first launch opens the sign-in screen. Sign in with the demo account (the **Use it** button fills it in), or create a new account in one of the sample companies.

| Email | Password |
|---|---|
| `mario.rossi@northwind.dev` | `scoreboard` |

> The `android`, `ios` and `web` folders are the default Flutter scaffolding. The app depends on `window_manager` and targets desktop only.

### Platform differences

- **macOS**: the title bar is hidden. The content extends under it, next to the traffic lights, and the top edge of the window is draggable.
- **Windows and Linux**: the native title bar is kept, with its minimize, maximize and close buttons.

Both behaviors are defined in [lib/core/window_chrome.dart](lib/core/window_chrome.dart).

## Data and persistence

There is no backend yet. All data goes through the `ScoreboardRepository` interface ([lib/services/scoreboard_repository.dart](lib/services/scoreboard_repository.dart)), and the app currently uses `MockScoreboardRepository`, a local stand-in:

- **Seed data**: 4 companies, 12 people and their achievements. It is rebuilt at every launch.
- **Saved data**: everything created in the app is stored with `shared_preferences` and survives restarts. That covers accounts, profile edits, base achievements and sent achievements.
- **Images**: profile photos and covers are copied into the app's support directory, so moving or deleting the original file doesn't break them.
- **Passwords**: stored as salted SHA-256 hashes, never in plain text. This is fine for a local mock. A real backend should hash passwords server-side with a slow algorithm such as bcrypt or Argon2.

To connect a real backend, implement `ScoreboardRepository` (the HTTP client in [lib/api](lib/api) is a starting point) and register it in [lib/core/locator/locator_objects.dart](lib/core/locator/locator_objects.dart). Business rules, such as who can send what, the XP limits and the one-per-colleague rule, live in the interactors, so they don't change. They should also be enforced by the server.

## Architecture

The app follows an MVVM-style structure wired with [`get_it`](https://pub.dev/packages/get_it):

```
View (State) ──calls──▶ ViewModel ──calls──▶ Interactor ──calls──▶ Repository / Services
     ▲                      │
     └──── contract ────────┘   (the ViewModel asks the View to navigate, show dialogs, …)
```

- **Views** implement a *view contract*. They render the state and forward user actions.
- **ViewModels** hold the screen state, a `ChangeNotifier` exposed through `provider`, and call interactors.
- **Interactors** contain the business rules:
  - `ScoreboardInteractor`: achievements, leaderboards, profile.
  - `AuthInteractor`: accounts and passwords.
  - `AppConfigurationInteractor`: theme and app info.
- **Services** wrap the data source and the platform: repository, preferences, file picker, image storage, package info.

```
lib/
├── app/           MaterialApp, routes, themes
├── core/          theme, locator (get_it), routing, formatters
├── interactors/   business rules
├── model/         plain data classes
├── services/      repository interface, mock repository, platform services
├── views/         one folder per screen: contract, view model, view
│   ├── _base/     base classes shared by every screen
│   └── _shared/   flows reused by several screens (sending an achievement)
└── widgets/       reusable widgets: cards, dialogs, sidebar, leaderboard rows
```

## Development

```sh
flutter analyze        # lints (flutter_lints)
dart format lib        # formatting
flutter build macos    # release build (also: windows, linux)
```

Notes:

- The UI uses the **Inter** typeface through `google_fonts`. It is downloaded at runtime and cached. On macOS, both the Debug and Release entitlements include `com.apple.security.network.client` for that.
- Picking images on macOS needs `com.apple.security.files.user-selected.read-only`, which is also enabled.
- On macOS, `package_info_plus`, `screen_retriever` and `window_manager` don't support Swift Package Manager yet. Flutter prints a warning and falls back to CocoaPods.
- Localization is set up with `flutter_intl` (`lib/l10n`), but the strings aren't extracted yet and the UI is in English.

## License

Released under the [Apache License 2.0](LICENSE).
