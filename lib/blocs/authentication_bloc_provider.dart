import 'package:flutter/material.dart';
import 'authentication_bloc.dart';

class AuthenticationBlocProvider extends InheritedWidget {
  final AuthenticationBloc authenticationBloc;


  const AuthenticationBlocProvider({this.authenticationBloc , Key key, Widget child})
  : super(key: key, child: child);

  static AuthenticationBlocProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AuthenticationBlocProvider>());
  }

  @override
  bool updateShouldNotify(AuthenticationBlocProvider oldWidget) {
    return authenticationBloc != oldWidget.authenticationBloc;
  }
}