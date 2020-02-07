import 'package:flutter/material.dart';
import '../blocs/authentication_bloc.dart';
import '../blocs/authentication_bloc_provider.dart';
import '../blocs/home_bloc.dart';
import '../blocs/home_bloc_provider.dart';
import '../blocs/journal_edit_bloc.dart';
import '../blocs/journal_edit_bloc_provider.dart';
import '../classes/format_dates.dart';
import '../classes/mood_icons.dart';
import '../models/journal.dart';
import 'edit_entry.dart';
import '../services/db_firestore.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthenticationBloc _authenticationBloc;
  HomeBloc _homeBloc;
  String _uid;
  MoodIcons _moodIcons = MoodIcons();
  final FormatDates _formatDates = FormatDates();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authenticationBloc = AuthenticationBlocProvider.of(context).authenticationBloc;
    _homeBloc = HomeBlocProvider.of(context).homeBloc;
    _uid = HomeBlocProvider.of(context).uid;
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  //Add or edit journal entry and call the show entry dialog
  void _addOrEditJournal({bool add, Journal journal}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => JournalEditBlocProvider(
          journalEditBloc: JournalEditBloc(add, journal, DbFirestoreService()),
          child: EditEntry(),
        ),
        fullscreenDialog: true,
      )
    );
  }

  Future<bool> _confirmDeleteJournal() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Journal'),
          content: Text('Are you sure you want to Delete?'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  'DELETE',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            )
          ],
        );
      }
    );
  }

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
              //transform: GradientRotation(math.pi/3),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.lightGreen.shade900,),
            onPressed: () {
              _authenticationBloc.logoutUser.add(true);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 44.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen.shade50, Colors.lightGreen],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _addOrEditJournal(add: true, journal: Journal(uid: _uid));
        },
        tooltip: 'Add/edit entry',
        backgroundColor: Colors.lightGreen.shade300,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        initialData: null,
        stream: _homeBloc.listJournal,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return _buildListViewSeparated(snapshot);
          } else {
            return Center(
              child: Container(
                child: Text('Add Journals.'),
              ),
            );
          }
        },
      ),
    );
  }

  ListView _buildListViewSeparated(AsyncSnapshot snapshot) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          String _titleDate = _formatDates.dateFormatShortMDY(snapshot.data[index].date);
          String _subtitle = snapshot.data[index].mood + '\n' + snapshot.data[index].note;
          return Dismissible(
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white,),
              padding: EdgeInsets.only(left: 16.0),
            ),
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white,),
              padding: EdgeInsets.only(left: 16.0),
            ),
            child: ListTile(
              leading: Column(
                children: <Widget>[
                  Text(_formatDates.dateFormatDayNumber(snapshot.data[index].date),
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_formatDates.dateFormatShortDayName(snapshot.data[index].date)),
                ],
              ),
              trailing: Transform(
                transform: Matrix4.identity()..rotateZ(_moodIcons.getMoodRotation(snapshot.data[index].mood)),
                alignment: Alignment.center,
                child: Icon(_moodIcons.getMoodIcons(snapshot.data[index].mood),
                  size: 42.0,
                  color: _moodIcons.getMoodColor(snapshot.data[index].mood),
                ),
              ),
              title: Text(_titleDate,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_subtitle),
              onTap: () {
                _addOrEditJournal(add: false, journal: snapshot.data[index]);
              },
            ),
            key: Key(snapshot.data[index].documentID),
            confirmDismiss: (direction) async {
              bool confirmDelete = await _confirmDeleteJournal();
              if(confirmDelete) {
                _homeBloc.deleteJournal.add(snapshot.data[index]);
              }
              return confirmDelete;
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
          );
        },
        itemCount: snapshot.data.length);
  }
}
