
class Journal {
  String note;
  String mood;
  String date;
  String uid;
  String documentID;

  Journal({this.mood, this.date, this.note, this.documentID, this.uid});

  factory Journal.fromDoc(dynamic doc) => Journal(
    documentID: doc.documentID,
    date: doc["date"],
    mood: doc["mood"],
    uid: doc["uid"],
    note: doc["note"],
  );


}