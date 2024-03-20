import 'package:scoreboard/model/achievement.dart';
import 'package:flutter/material.dart';

class InteractiveCard extends StatefulWidget {
  final Achievement achievement;
  final VoidCallback onPressed;

  const InteractiveCard(
      {super.key, required this.achievement, required this.onPressed});

  @override
  _InteractiveCardState createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<InteractiveCard> {
  double x = 0.0;
  double y = 0.0;
  bool isHovering = false;
  Size cardSize = const Size(180, 250);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey(widget.achievement.id),
      child: GestureDetector(
        onTap: () => widget.onPressed(),
        child: MouseRegion(
          onEnter: (event) => setState(() => isHovering = true),
          onExit: (event) => setState(() => isHovering = false),
          onHover: (event) {
            setState(() {
              x = (event.localPosition.dx - (cardSize.width / 2)) / 10;
              y = (event.localPosition.dy - (cardSize.height / 2)) / 10;
            });
          },
          child: Transform(
            transform: (isHovering
                ? Matrix4.diagonal3Values(1.1, 1.1, 1)
                : Matrix4.identity())
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateX(isHovering ? y / 100 : 0)
              ..rotateY(isHovering ? x / 100 : 0),
            alignment: FractionalOffset.center,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              color: const Color.fromARGB(255, 247, 245, 226), // Gold color
              elevation: 10,
              child: SizedBox(
                width: cardSize.width,
                height: cardSize.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: FlutterLogo(
                                size: 160,
                              ))), // Placeholder for logo

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.achievement.name!,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _textColors),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            widget.achievement.company!,
                            style: TextStyle(fontSize: 10, color: _textColors),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.achievement.date!.day}/${widget.achievement.date!.month}/${widget.achievement.date!.year}',
                            style: TextStyle(fontSize: 8, color: _textColors),
                          ),
                          const Spacer(),
                          if (widget.achievement.verified!)
                            const Tooltip(
                              message: "Verified",
                              child: Icon(
                                Icons.verified,
                                semanticLabel: "Verified",
                                color: Colors.blue,
                                size: 16,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _textColors = const Color.fromRGBO(111, 43, 23, 1);
}
