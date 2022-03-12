import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  final TextStyle MyStyle = const TextStyle(color: Colors.white, fontSize: 18);

  late double ScreenHeight, ScreenWidth;
  bool IsMenuopen = false;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<Offset> MenuOffsetAnimation;
  late Animation<double> MenuScaleAnimation;

  final Duration duration = Duration(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 1, end: 0.6).animate(animationController);
    MenuOffsetAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    MenuScaleAnimation =
        Tween<double>(begin: 0.0, end: 1).animate(animationController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenHeight = MediaQuery.of(context).size.height;
    ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          children: [CreateMenuDashboard(context), CreateDashboard(context)],
        ),
      ),
    );
  }

  CreateMenuDashboard(BuildContext context) {
    return SlideTransition(
      position: MenuOffsetAnimation,
      child: ScaleTransition(
        scale: MenuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dashboard",
                  style: MyStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Mesajlar",
                  style: MyStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Utility Bills",
                  style: MyStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Fund Transfer",
                  style: MyStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Branches",
                  style: MyStyle,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CreateDashboard(BuildContext context) {
    return AnimatedPositioned(
      top: IsMenuopen ? 0.1 * ScreenHeight : 0,
      bottom: IsMenuopen ? 0.1 * ScreenHeight : 0,
      left: IsMenuopen ? 0.6 * ScreenWidth : 0,
      right: IsMenuopen ? -0.4 * ScreenWidth : 0,
      duration: Duration(milliseconds: 500),
      child: ScaleTransition(
        scale: animation,
        child: Material(
          borderRadius:
              IsMenuopen ? BorderRadius.circular(12) : BorderRadius.circular(0),
          elevation: 8,
          color: Colors.black,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      setState(() {
                        if (IsMenuopen) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                        IsMenuopen = !IsMenuopen;
                      });
                    },
                    color: Colors.white,
                  ),
                  Text(
                    "My Cards",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  )
                ],
              ),
              Container(
                height: 700,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      color: Colors.pink,
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Container(
                      color: Colors.purple,
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Container(
                      color: Colors.green,
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
