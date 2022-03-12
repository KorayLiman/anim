import 'package:flutter/material.dart';

class TransformWidgets extends StatefulWidget {
  const TransformWidgets({Key? key}) : super(key: key);

  @override
  State<TransformWidgets> createState() => _TransformWidgetsState();
}

class _TransformWidgetsState extends State<TransformWidgets> {
  double Slidervalue = 0;
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [GetSlider(), GetRotation(), GetScale(), GetTranslation()],
      ),
    );
  }

  GetSlider() {
    return Slider(
        max: 20,
        min: 0,
        value: Slidervalue,
        onChanged: (value) {
          setState(() {
            Slidervalue = value;
            scale = value;
          });
        });
  }

  GetRotation() {
    return Container(
      child: Transform.rotate(
        origin: Offset(20, 0),
        angle: Slidervalue,
        child: Container(
          height: 100,
          width: 100,
          color: Colors.blue,
        ),
      ),
    );
  }

  GetScale() {
    return Container(
      child: Transform.scale(
        scale: scale,
        child: Container(
          height: 100,
          width: 100,
          color: Colors.green,
        ),
      ),
    );
  }

  GetTranslation() {
    return Container(
      child: Transform.translate(
        offset: Offset(Slidervalue, 0),
        child: Container(
          color: Colors.orange,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
