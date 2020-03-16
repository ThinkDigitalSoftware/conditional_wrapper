import 'package:conditional_wrapper/conditional_wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ConditionalWrapperHome());
}

class ConditionalWrapperHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conditional Wrapper Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final containerKey = GlobalKey(debugLabel: 'container');
final containerKey2 = GlobalKey(debugLabel: 'container2');

class _MyHomePageState extends State<MyHomePage> {
  bool shouldWrap1 = false;
  bool showFirstOption = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conditional Wrapper Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't Wrap"),
                  Switch.adaptive(
                      value: shouldWrap1,
                      onChanged: (value) {
                        setState(() {
                          shouldWrap1 = value;
                        });
                      }),
                  Text('Wrap'),
                ],
              ),
              ConditionalWrapper(
                condition: shouldWrap1,
                child: Text(shouldWrap1 ? 'Wrapped' : 'Unwrapped'),
                builder: (BuildContext context, Widget child) {
                  return Column(
                    children: <Widget>[
                      Container(
                        key: containerKey,
                        padding: EdgeInsets.all(20),
                        child: child,
                        color: Colors.blue,
                      ),
                      Text('Some other child inside a Column'),
                    ],
                  );
                },
              ),
            ],
          ),
          Divider(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("First Wrap Option"),
                  Switch.adaptive(
                      value: showFirstOption,
                      onChanged: (value) {
                        setState(() {
                          showFirstOption = value;
                        });
                      }),
                  Text('Second Wrap Option'),
                ],
              ),
              ConditionalWrapper(
                condition: !showFirstOption,
                ifFalse: (context, child) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2)),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('This is the second'),
                      child,
                      Text('wrapping option'),
                    ],
                  ),
                ),
                child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.blue,
                    child: Text('Child Widget')),
                builder: (BuildContext context, Widget child) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Text('This is the first'),
                        child,
                        Text('wrapping option'),
                      ],
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
