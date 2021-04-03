import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'main.dart';
import 'particle_field.dart';
import 'particle_field_painter.dart';
import 'components/sprite_sheet.dart';

class ParticleSwipeDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParticleSwipeDemoState();
  }
}

class ParticleSwipeDemoState extends State<ParticleSwipeDemo>
    with SingleTickerProviderStateMixin {
  SpriteSheet _spriteSheet;
  ParticleField _particleField;
  Ticker _ticker;

  @override
  void initState() {
    // Create the "sparkle" sprite sheet for the particles:
    _spriteSheet = SpriteSheet(
      imageProvider: AssetImage(
        "images/circle_spritesheet.png",
        package: App.pkg,
      ),
      length: 15, // number of frames in the sprite sheet.
      frameWidth: 10,
      frameHeight: 10,
    );

    _particleField = ParticleField();
    _ticker = createTicker(_particleField.tick)..start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _particleField.pointExplosion(200, 200, 100);
          },
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text('hi'),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: ParticleFieldPainter(
                field: _particleField,
                spriteSheet: _spriteSheet,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
