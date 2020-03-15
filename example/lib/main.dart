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

class _MyHomePageState extends State<MyHomePage> {
  bool shouldWrap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conditional Wrapper Example'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Don't Wrap"),
              Switch.adaptive(
                  value: shouldWrap,
                  onChanged: (value) {
                    setState(() {
                      shouldWrap = value;
                    });
                  }),
              Text('Wrap'),
            ],
          ),
          Divider(),
          ConditionalWrapper(
            condition: shouldWrap,
            child: Text(shouldWrap ? 'Wrapped' : 'Unwrapped'),
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
    );
  }
}
