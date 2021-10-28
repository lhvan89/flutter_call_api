import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_api/cubit/base_cubit.dart';

abstract class BaseStatelessWidget<C extends BaseCubit> extends StatelessWidget {
  late BuildContext context;
  final String? title;
  final C cubit;
  bool _isInit = true;

  BaseStatelessWidget({this.title, required this.cubit});

  Widget body(BuildContext context);

  void initState(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    debugPrint("Rebuild: ${this.runtimeType}");
    this.context = context;
    cubit.setContext(context);
    return BlocProvider(
        create: (childContext) {
          if (this._isInit) {
            this.initState(context);
            this._isInit = false;
          }
          return cubit;
        },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? ''),
        ),
        body: body(context),
      ),
    );
  }
}