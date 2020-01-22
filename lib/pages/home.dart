import 'package:flutter/material.dart';
import 'dart:math' as math;


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
        automaticallyImplyLeading: false,
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
              transform: GradientRotation(math.pi/3),
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
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 44.0,
          /*decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen.shade200, Colors.lightGreen],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),*/
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO add navigator to edit/add journal entry page
        },
        tooltip: 'Add/edit entry',
        backgroundColor: Colors.lightGreen.shade300,
        child: Icon(Icons.add),
      ),
    );
  }
}
