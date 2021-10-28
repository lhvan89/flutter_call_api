import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';

abstract class BaseCubit extends Cubit<bool> {
  BuildContext? _context;

  void setContext(BuildContext buildContext) {
    _context = buildContext;
  }

  BaseCubit() : super(false) {
    debugPrint("Init cubit: $runtimeType");
    initCubit();
  }

  void initCubit() {
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}