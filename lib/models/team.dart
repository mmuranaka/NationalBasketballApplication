import '../utils/db_helper.dart';
class Team {
  int? id;
  int apiID;
  String name;
  String conference;
  String division;

  Team({
    this.id,
    required this.apiID,
    required this.name,
    required this.conference,
    required this.division,
  });

  Future<void> dbSave() async {
    id = await DBHelper().insert('team', {
      'apiID': apiID,
      'name': name,
      'division': division,
      'conference': conference,
    });
  }

  Future<void> dbEdit() async {
    await DBHelper().update('team', {
      'apiID': apiID,
      'name': name,
      'division': division,
      'conference': conference,
    });
  }
}