class Model{

  String time;
  String meal;
  String bites;
  String totalTime;


  Model (this.time,this.meal,this.bites,this.totalTime);

  String get getTime{
    return time;
  }

  void set setTime(String time){
    this.time=time;
  }
  String get getMeal{
    return meal;
  }

  void set setMeal(String meal){
    this.meal=meal;
  }
  String get getBites{
    return bites;
  }

  void set setBites(String bites){
    this.bites=bites;
  }
  String get getTotalTime{
    return totalTime;
  }

  void set setTotalTime(String totalTime){
    this.totalTime=totalTime;
  }



  Model.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        meal = json['meal'],
        bites = json['bites'],
        totalTime = json['totalTime'];

  Map<String, dynamic> toJson() => {
    'time': time,
    'meal': meal,
    'bites': bites,
    'totalTime': totalTime,
  };
}