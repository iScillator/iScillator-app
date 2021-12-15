import 'package:flutter/material.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({Key? key, required this.onPlayingChange}) : super(key: key);

  final Function onPlayingChange;

  @override
  _PlayButton createState() => _PlayButton();
}

class _PlayButton extends State<PlayButton> {
  bool _highlight = false;
  bool _isPlaying = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    _isPlaying = !_isPlaying;
    widget.onPlayingChange();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTap: _handleTap,
        onTapCancel: _handleTapCancel,
        child: Opacity(
          child: Image.asset(
            !_isPlaying ? 'images/play_button.png' : 'images/pause_button.png',
            height: 120.0,
            width: 120.0,
          ),
          opacity: _highlight ? 0.7 : 1.0,
        ));
  }
}
