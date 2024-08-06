import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseView<T extends GetxController> extends StatelessWidget {
  final T model;
  final Function(T) onModelReady;
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  const BaseView({
    super.key,
    required this.model,
    required this.onModelReady,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    // Use GetX dependency injection
    return GetBuilder<T>(
      init: model,
      initState: (controller) => onModelReady(model),
      builder: (controller) => builder(context, model, null),
    );
  }
}
