library conditional_wrapper;

import 'package:flutter/widgets.dart';

typedef ConditionalWrapperBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

class ConditionalWrapper extends StatelessWidget {
  const ConditionalWrapper({
    Key? key,
    required this.condition,
    required this.builder,
    this.ifFalse,
    required this.child,
  }) : super(key: key);

  /// if [condition] evaluates to true, the builder will be run and the child will
  /// be wrapped. If false, only the child is returned.
  final bool condition;

  /// Child builder to use when [condition] is true.
  final ConditionalWrapperBuilder builder;

  /// Alternative builder to use when [condition] is false.
  ///
  /// If not provided, the child is displayed.
  final ConditionalWrapperBuilder? ifFalse;

  /// The widget to be conditionally wrapped. This will be displayed alone if [condition] is false.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return builder(context, child);
    } else if (ifFalse != null) {
      return ifFalse!(context, child);
    } else {
      return child;
    }
  }
}
