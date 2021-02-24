import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/conditional_wrapper.dart';

final GlobalKey switchBtn = GlobalKey();
final GlobalKey hiddenContainer = GlobalKey();
final GlobalKey text = GlobalKey();

void main() {
  group('wrapping & unwrapping', () {
    testWidgets('switch states', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ConditionalWrapperTestWidget(),
          ),
        ),
      );

      final Finder switchFinder = find.byKey(switchBtn);
      expect(switchFinder, findsOneWidget);

      final Finder containerFinder = find.byKey(hiddenContainer);
      expect(containerFinder, findsNothing);

      final Finder textFinder = find.byKey(text);
      expect(textFinder, findsOneWidget);

      // wrap
      await tester.tap(switchFinder);
      await tester.pump();

      expect(switchFinder, findsOneWidget);
      expect(containerFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    });
  });
}

class ConditionalWrapperTestWidget extends StatefulWidget {
  @override
  _ConditionalWrapperTestWidgetState createState() =>
      _ConditionalWrapperTestWidgetState();
}

class _ConditionalWrapperTestWidgetState
    extends State<ConditionalWrapperTestWidget> {
  bool isWrapped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch.adaptive(
          key: switchBtn,
          value: isWrapped,
          onChanged: (newVal) => setState(() => isWrapped = newVal),
        ),
        ConditionalWrapper(
          condition: isWrapped,
          child: Text('', key: text),
          builder: (context, child) {
            return Column(
              children: <Widget>[
                Container(
                  key: hiddenContainer,
                  child: child,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
