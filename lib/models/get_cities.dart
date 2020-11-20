class GetCities {
  List<Cities> cities;

  GetCities({this.cities});

  GetCities.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities.add(Cities.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (cities != null) {
      data['cities'] = cities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  String displayName;
  String tag;
  String thumbnail;

  Cities({this.displayName, this.tag, this.thumbnail});

  Cities.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'] as String;
    tag = json['tag'] as String;
    thumbnail = json['thumbnail'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['tag'] = tag;
    data['thumbnail'] = thumbnail;
    return data;
  }
}