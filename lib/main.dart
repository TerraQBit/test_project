
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  late AnimationController _controller;
  bool isLeftButtonClicked = false;
  bool isRightButtonClicked = true;


  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RedSquare(context, _controller, -MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.width/2),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            color: isLeftButtonClicked ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Left',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        if (isLeftButtonClicked) {
                          setState(() {
                            isLeftButtonClicked = !isLeftButtonClicked;
                          });
                          _controller.reverse().then((value) => setState(() {isRightButtonClicked = !isRightButtonClicked;}));
                        }
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            color: isRightButtonClicked ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Right',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        if (isRightButtonClicked) {
                          setState(() {
                            isRightButtonClicked = !isRightButtonClicked;
                          });
                        _controller.forward().then((value) => setState(() {isLeftButtonClicked = !isLeftButtonClicked;}));
                        }
                      },
                    )
                  ],
                ),
            )
          ],
        )
      ),
    );
  }
}

Widget RedSquare(BuildContext context, AnimationController controller, double start, double end) {

  const squareSize = 50.0;
  Animation<double> _animation = Tween<double>(begin: start+squareSize/2, end: end-squareSize).animate(controller);


  return AnimatedBuilder(
    animation: controller.view,
    builder: (context, child) {
      return Transform.translate(
        offset: Offset(_animation.value, 0),
        child: child,
      );
    },
    child: GestureDetector(
      child: Container(
        color: Colors.red,
        height: squareSize,
        width: squareSize,
      ),
    )
  );
}
