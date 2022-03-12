import 'package:anim/TransformWidgets.dart';
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
  Color color = Colors.pink;
  double width = 50;
  double height = 50;
  bool IsFirstActive = true;
  double opacity = 1.0;
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
            animatable: Tween<double>(begin: 100, end: 200),
            from: Duration(seconds: 2),
            curve: Curves.easeInOut,
            to: Duration(seconds: 3),
            tag: "height")
        .addAnimatable(
            animatable: EdgeInsetsTween(
                begin: EdgeInsets.all(0), end: EdgeInsets.all(40)),
            from: Duration(seconds: 3),
            to: Duration(seconds: 4),
            tag: "EdgeInsets")
        .addAnimatable(
            animatable: BorderRadiusTween(
                begin: BorderRadius.circular(0),
                end: BorderRadius.circular(60)),
            from: Duration(seconds: 3),
            to: Duration(seconds: 4),
            tag: "BorderRadius")
        .addAnimatable(
            animatable: ColorTween(begin: Colors.red, end: Colors.blue),
            from: Duration(seconds: 4),
            to: Duration(seconds: 5),
            tag: "Color")
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
        child: Column(
          children: [
            AnimatedContainer(
              height: height,
              width: width,
              color: color,
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    width = 200;
                    height = 200;
                    color = Colors.green;
                  });
                },
                child: const Text("Button")),
            AnimatedCrossFade(
                firstChild: Image.network(
                    "https://stimg.cardekho.com/images/carexteriorimages/930x620/Lamborghini/Aventador/6721/Lamborghini-Aventador-SVJ/1621849426405/front-left-side-47.jpg?tr=w-375"),
                secondChild: Image.network(
                    "https://media.istockphoto.com/photos/red-generic-sedan-car-isolated-on-white-background-3d-illustration-picture-id1189903200?k=20&m=1189903200&s=612x612&w=0&h=L2bus_XVwK5_yXI08X6RaprdFKF1U9YjpN_pVYPgS0o="),
                crossFadeState: IsFirstActive
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(seconds: 2)),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    IsFirstActive = !IsFirstActive;
                  });
                },
                child: const Text("Button")),
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 2),
              child: FlutterLogo(),
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    opacity = opacity == 1.0 ? 0.0 : 1.0;
                  });
                },
                child: const Text("Opacity")),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransformWidgets(),
                      ));
                },
                child: const Text("Transform"))
          ],
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
