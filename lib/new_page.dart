import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this);
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: Duration.zero,
            to: Duration(seconds: 1),
            tag: "opacity")
        .addAnimatable(
            animatable: Tween<double>(begin: 50, end: 150),
            from: Duration(seconds: 1),
            to: Duration(seconds: 2),
            tag: "width")
        .addAnimatable(
            animatable:   Tween<double>(begin: 100,end: 200),
            from: Duration(seconds: 2),curve: Curves.easeInOut,
            to: Duration(seconds: 3),
            tag: "height").addAnimatable(animatable: EdgeInsetsTween(begin: EdgeInsets.all(0),
            end: EdgeInsets.all(40)), from: Duration(seconds: 3), to: Duration(seconds: 4), tag: "EdgeInsets")
            .addAnimatable(animatable: BorderRadiusTween(begin: BorderRadius.circular(0),end: BorderRadius.circular(60)) , from:
            Duration(seconds:3) , to: Duration(seconds:4), tag: "BorderRadius")
            .addAnimatable(animatable: ColorTween(begin: Colors.red,end: Colors.blue), from:
            Duration(seconds: 4), to: Duration(seconds: 5), tag: "Color")
        .animate(animationController);
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
child: AnimatedContainer(duration: Duration(seconds: 2),
),

        // child: AnimatedBuilder(
        //   animation: animationController,
        //   builder: (context, widget) {
        //     return Padding(
        //       padding: sequenceAnimation["EdgeInsets"].value,
        //       child: Opacity(
        //           opacity: sequenceAnimation["opacity"].value,
        //           child: Container(decoration: BoxDecoration(color: sequenceAnimation["Color"].value,borderRadius: sequenceAnimation["BorderRadius"].value),
                      
        //               height: sequenceAnimation["height"].value,
        //               width: sequenceAnimation["width"].value)),
        //     );
        //   },
        // ),
      ),
    );
  }
}
