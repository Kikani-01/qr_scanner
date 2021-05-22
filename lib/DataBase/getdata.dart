class Databasedata {
  var saveResult;
  var date;
  int id;
  int isFavourite;
  Databasedata({this.id, this.saveResult, this.date, this.isFavourite});

  Map<String, dynamic> toMap() {
    return {
      "saveResult": saveResult,
      "date": date,
      "isFavourite": isFavourite,
    };
  }
/*
  Databasedata.name(Map<String, dynamic> map) {
    this.id = map['id'];
    this.saveResult = map['saveResult'];
    this.date = map['date'];
    this.isFavourite = map['isFavourite'];
  }*/
}
