import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal',
        style: TextStyle(
          color: Colors.lightGreen.shade900,
          ),
        ),
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(32.0),
          child: Container(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen, Colors.lightGreen.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.lightGreen.shade900,),
            onPressed: () {
              //TODO add signout method
            },
          ),
        ],
      ),
      bottomNavigationBar: ,
    );
  }
}
