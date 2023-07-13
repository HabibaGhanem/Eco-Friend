class CarbonFootprint {

  String? userID;
  double? value;
  String? startDate;
  //String? endDate;
  double? carType;
  double? carEfficiency;
  double? car_TraveledDistance;
  double? shortFlightsNumber;
  double? longFlightsNumber;
  double? redMeatServings;
  double? whiteMeatServings;
  double? dairyServings;
  double? livingSpaceArea;
  double? catNumber;
  double? dogNumber;
  double? bus_TraveledDistance;
  double? metro_TraveledDistance;
  double? rail_TraveledDistance;
  double? furnitureAndAppliances_Spendings;
  double? clothes_Spendings;
  double? otherStuff_Spendings;
  double? services_Spendings;
  double? electricityConsumption;
  double? naturalGasConsumption;

  CarbonFootprint({this.userID,this.value,this.startDate//,this.endDate
    ,this.carType,this.carEfficiency
  ,this.car_TraveledDistance,this.shortFlightsNumber,this.longFlightsNumber,this.redMeatServings,
  this.whiteMeatServings,this.dairyServings,this.livingSpaceArea,this.catNumber,this.dogNumber,
  this.bus_TraveledDistance,this.metro_TraveledDistance,this.rail_TraveledDistance,this.furnitureAndAppliances_Spendings,
  this.clothes_Spendings,this.otherStuff_Spendings,this.services_Spendings,this.electricityConsumption,
  this.naturalGasConsumption});

  Map<String, dynamic> toMap()
  {
    Map<String, dynamic> map={
      'userID':this.userID,
      'value':this.value,
      'startDate':this.startDate,
      //'endDate':this.endDate,
      'carType':this.carType,
      'carEfficiency':this.carEfficiency,
      'car_TraveledDistance':this.car_TraveledDistance,
      'shortFlightsNumber':this.shortFlightsNumber,
      'longFlightsNumber':this.longFlightsNumber,
      'redMeatServings':this.redMeatServings,
      'whiteMeatServings':this.whiteMeatServings,
      'dairyServings':this.dairyServings,
      'livingSpaceArea':this.livingSpaceArea,
      'catNumber':this.catNumber,
      'dogNumber':this.dogNumber,
      'bus_TraveledDistance':this.bus_TraveledDistance,
      'metro_TraveledDistance':this.metro_TraveledDistance,
      'rail_TraveledDistance':this.rail_TraveledDistance,
      'furnitureAndAppliances_Spendings':this.furnitureAndAppliances_Spendings,
      'clothes_Spendings':this.clothes_Spendings,
      'otherStuff_Spendings':this.otherStuff_Spendings,
      'services_Spendings':this.services_Spendings,
      'electricityConsumption':this.electricityConsumption,
      'naturalGasConsumption':this.naturalGasConsumption
    };
    return map;
  }
  CarbonFootprint.fromJson(Map<String, dynamic> json){
    userID=json['userID'];
    value=json['value'];
    startDate=json['startDate'];
    //endDate=json['endDate'];
    carType=json['carType'];
    carEfficiency=json['carEfficiency'];
    car_TraveledDistance=json['car_TraveledDistance'];
    shortFlightsNumber=json['shortFlightsNumber'];
    longFlightsNumber = json['longFlightsNumber'];
    redMeatServings= json['redMeatServings'];
    dairyServings=json['dairyServings'];
    livingSpaceArea=json['livingSpaceArea'];
    catNumber=json['catNumber'];
    dogNumber=json['dogNumber'];
    bus_TraveledDistance=json['bus_TraveledDistance'];
    metro_TraveledDistance=json['metro_TraveledDistance'];
    rail_TraveledDistance=json['rail_TraveledDistance'];
    clothes_Spendings=json['clothes_Spendings'];
    otherStuff_Spendings=json['otherStuff_Spendings'];
    services_Spendings=json['services_Spendings'];
    electricityConsumption=json['electricityConsumption'];
    naturalGasConsumption=json['naturalGasConsumption'];

  }

}