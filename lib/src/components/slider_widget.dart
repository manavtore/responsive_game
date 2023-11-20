import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const SliderWidget({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
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
            min: -1,
            max: 1,
          ),
        ),
      ],
    );
  }
}
