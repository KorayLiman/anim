import 'package:anim/new_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController animationController;

  //late Animation<double> animation;
  late Animation animation;
  late Animation animation2;
  late Animation animation3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      // lowerBound: 20,
      // upperBound: 100);
    );

    animationController.addListener(() {
      setState(() {
        print(animationController.value.toString());
      });
    });

    //animation = Tween<double>(begin: 20, end: 50).animate(animationController);
    animation = ColorTween(begin: Colors.red, end: Colors.yellow)
        .animate(animationController);
    animation2 = AlignmentTween(begin: Alignment(-1, -1), end: Alignment(1, 1))
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.easeInExpo));
    animation3 = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutExpo);
    animationController.forward(from: 00);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        animationController.reverse().orCancel;
      else if (status == AnimationStatus.dismissed)
        animationController.forward().orCancel;

      print(status);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal.withOpacity(animationController.value / 100),
      backgroundColor: animation.value,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: animation3.value * 36),
            ),
            Container(
              height: 100,
              alignment: animation2.value,
              child: Text('$_counter',
                  style: TextStyle(fontSize: 24, color: Colors.black)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
