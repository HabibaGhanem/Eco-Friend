class userHabit{
  String? userID;
  String? habitID;
  bool isCompleted = false; //doneCounter == 21
  int doneCounter = 0;
  List<bool> daysList = List.filled(21,false);
  String? startDate = (DateTime.now()).toString();

  userHabit({this.userID, this.habitID});

  Map<String, dynamic> toMap()
  {
    Map<String, dynamic> map={
      'userID':this.userID,
      'habitID':this.habitID,
      'isCompleted':this.isCompleted,
      'daysList':this.daysList,
      'doneCounter':this.doneCounter,
      'startDate':this.startDate,
    };
    return map;
  }

}