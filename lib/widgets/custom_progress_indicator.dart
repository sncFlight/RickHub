import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/constants/sound_paths.dart';

class CustomProgressIndicator extends StatefulWidget {
  final double size;

  const CustomProgressIndicator({
    Key? key,
    this.size = 200.0
  }) : super(key: key);

  @override
  _CustomProgressIndicatorState createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => AudioPlayer().play(AssetSource(SoundPaths.rickBelch)),
        child: RotationTransition(
          turns: _controller,
          child: Image.asset(
            ImagePaths.rickBelch,
            width: widget.size,
            height: widget.size,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
