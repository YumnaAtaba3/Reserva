import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum ThemeModeEvent { toggle }

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeMode> {
  ThemeModeBloc() : super(ThemeMode.light);

  @override
  Stream<ThemeMode> mapEventToState(ThemeModeEvent event) async* {
    switch (event) {
      case ThemeModeEvent.toggle:
        yield state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
        break;
    }
  }
}
enum ThemeMode { light, dark }