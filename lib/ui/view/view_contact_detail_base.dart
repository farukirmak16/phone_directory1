import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView2<T extends ChangeNotifier> extends StatelessWidget {
  final T model;
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T) onModelReady;

  const BaseView2({super.key, required this.model, required this.builder, required this.onModelReady});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: builder,
      ),
    );
  }
}
