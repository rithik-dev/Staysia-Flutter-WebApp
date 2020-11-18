class GetCities {
  List<Cities> cities;
  List<Stars> stars;
  List<Tags> tags;

  GetCities({this.cities, this.stars, this.tags});

  GetCities.fromJson(dynamic json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities.add(Cities.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['stars'] != null) {
      stars = <Stars>[];
      json['stars'].forEach((v) {
        stars.add(Stars.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags.add(Tags.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (cities != null) {
      data['cities'] = cities.map((v) => v.toJson()).toList();
    }
    if (stars != null) {
      data['stars'] = stars.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags.map((v) => v.toJson()).toList();
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

class Stars {
  String displayName;
  String tag;
  String thumbnail;

  Stars({this.displayName, this.tag, this.thumbnail});

  Stars.fromJson(Map<String, dynamic> json) {
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

class Tags {
  String displayName;
  String tag;
  String thumbnail;

  Tags({this.displayName, this.tag, this.thumbnail});

  Tags.fromJson(Map<String, dynamic> json) {
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
