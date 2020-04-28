import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimationScreen(),
    );
  }
}

class AnimationScreen extends StatefulWidget{
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  double currentValue;
  Animation curveAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this
    );

    curveAnimation = CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);

    _animationController.addListener((){
      setState(() {
        currentValue = _animationController.value;
      });
    });

    _animationController.repeat();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$currentValue", style: TextStyle(fontSize: 30),),
            SizedBox(height: 60,),
            RotationTransition(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
              ),
              alignment: Alignment.center,
              turns: Tween<double>(begin: 0, end: 1).animate(curveAnimation),
            ),
          ],
        )

            /*
            Stack(
        children: <Widget>[
          PositionedTransition(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle
              ),
            ),
            rect: RelativeRectTween(begin: RelativeRect.fromLTRB(0, 0, 0, 700),
                end: RelativeRect.fromLTRB(200, 700, 0, 0),).animate(curveAnimation),
          )

        ],
      ),
             */
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.book),
        onPressed: (){
          if(_animationController.isAnimating){
            _animationController.stop();
          }else{
            _animationController.repeat();
          }
        },
      ),

    );
  }
}
