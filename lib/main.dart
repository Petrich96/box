import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const MyApp());
}

enum Position { left, center, right }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BoxScreen(),
    );
  }
}

class BoxScreen extends StatefulWidget {
  final boxKey = UniqueKey();
  final animateDuration = const Duration(seconds: 1);

  BoxScreen({super.key});

  @override
  State<StatefulWidget> createState() => BoxScreenState();
}

class BoxScreenState extends State<BoxScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PositionController>(
      create: (_) => PositionController(),
      child: SafeArea(child: Scaffold(
        body: Builder(builder: (BuildContext context) {
          var controller = Provider.of<PositionController>(context);
          var size = MediaQuery.of(context).size.width / 3;
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedAlign(
                  alignment: Alignment(controller.position.index - 1, 0),
                  duration: widget.animateDuration,
                  onEnd: controller.unlock,
                  child: Container(
                    width: size,
                    height: size,
                    color: Colors.red,
                  )),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                        onPressed:
                            (controller.isBusy || controller.position == Position.left) ? null : controller.moveLeft,
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    IconButton(
                        onPressed:
                            (controller.isBusy || controller.position == Position.right) ? null : controller.moveRight,
                        icon: const Icon(Icons.arrow_forward_ios)),
                  ],
                ),
              )
            ],
          ));
        }),
      )),
    );
  }
}

class PositionController extends ChangeNotifier {
  Position _position = Position.center;
  bool _busy = false;

  Position get position => _position;
  bool get isBusy => _busy;

  void moveLeft() {
    if (isBusy || _position == Position.left) return;
    _busy = true;
    _position = Position.left;
    notifyListeners();
  }

  void moveRight() {
    if (isBusy || _position == Position.right) return;
    _busy = true;
    _position = Position.right;
    notifyListeners();
  }

  void unlock() {
    _busy = false;
    notifyListeners();
  }
}
