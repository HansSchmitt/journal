import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'blocs/authentication_bloc.dart';
import 'blocs/authentication_bloc_provider.dart';
import 'blocs/home_bloc.dart';
import 'blocs/home_bloc_provider.dart';
import 'services/authentication.dart';
import 'services/db_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.

  @override
  Widget build(BuildContext context) {
    //We initialize an Authentication object. We inject the _authentication object into the AuthenticationBloc
    //_authentication creates a FirebaseAuth instance, and has methods available for signing in, out, or verifying login credentials
    //The _authenticationBloc class receives the _authentication service and starts
    //streams and sinks that will handle authentication and logging out of the authentication backend.
    final Authentication _authentication = Authentication();
    final AuthenticationBloc _authenticationBloc = AuthenticationBloc(_authentication);

    return AuthenticationBlocProvider(
      authenticationBloc: _authenticationBloc,
      child: StreamBuilder(
        initialData: null,
        stream: _authenticationBloc.user,//This is a stream that has information from the authentication service regarding the user uid
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.lightGreen,
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == true) {
            return HomeBlocProvider(
              homeBloc: HomeBloc(DbFirestoreService(),_authentication),
              child: _buildMaterialApp(Home()),
            );
          } else {
            return _buildMaterialApp(Login());
          }
        },
      ),
    );
  }

  MaterialApp _buildMaterialApp(Widget homePage) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Journal',
    theme: ThemeData(
      primarySwatch: Colors.lightGreen,
      bottomAppBarColor: Colors.lightGreen,
      canvasColor: Colors.lightGreen.shade50,
    ),
    home: homePage,
  );
  }
}
