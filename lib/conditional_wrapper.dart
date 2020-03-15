library conditional_wrapper;

import 'package:flutter/widgets.dart';

typedef ConditionalWrapperBuilder = Widget Function(
    BuildContext context, Widget child);

class ConditionalWrapper extends StatelessWidget {
  /// if [condition] evaluates to true, the builder will be run and the child will
  /// be wrapped. If false, only the child is returned.
  final bool condition;

  /// How to display the widget if [condition] is true;
  final ConditionalWrapperBuilder builder;

  /// The widget to be conditionally wrapped. This will be displayed alone if [condition] is false.
  final Widget child;

  const ConditionalWrapper({
    Key key,
    @required this.condition,
    @required this.builder,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return builder(context, child);
    } else {
      return child;
    }
  }
}
