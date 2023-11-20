import 'package:flutter/material.dart';

class SliderWidget2 extends StatefulWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const SliderWidget2({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  _SliderWidget2State createState() => _SliderWidget2State();
}

class _SliderWidget2State extends State<SliderWidget2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.label),
        SizedBox(
          width: 300,
          child: Slider(
            value: widget.value,
            onChanged: widget.onChanged,
            min: 0,
            max: 2,
          ),
        ),
      ],
    );
  }
}
