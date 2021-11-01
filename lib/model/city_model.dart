class CityModel {
  String id;
  String name;
  List<dynamic> neighborhoods;

  CityModel(this.name, this.neighborhoods);

  CityModel.fromJson(Map map) {
    this.id = map['id'];
    this.name = map['name'];
    this.neighborhoods = map['neighborhoods'];
  }
}
