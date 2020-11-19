class DetailedHotel {
  String address;
  String checkIn;
  String checkOut;
  String city;
  String description;
  String destinationId;
  FeatureBullets featureBullets;
  int id;
  String mainImage;
  String mapWidget;
  String neighbourhood;
  Price price;
  double rating;
  List<Review> review;
  Rooms rooms;
  int starRating;
  String title;

  DetailedHotel(
      {this.address,
      this.checkIn,
      this.checkOut,
      this.city,
      this.description,
      this.destinationId,
      this.featureBullets,
      this.id,
      this.mainImage,
      this.mapWidget,
      this.neighbourhood,
      this.price,
      this.rating,
      this.review,
      this.rooms,
      this.starRating,
      this.title});

  DetailedHotel.fromJson(Map<String, dynamic> json) {
    address = json['address'] as String;
    checkIn = json['checkIn'] as String;
    checkOut = json['checkOut'] as String;
    city = json['city'] as String;
    description = json['description'] as String;
    destinationId = json['destinationId'] as String;
    featureBullets = json['feature_bullets'] != null
        ? FeatureBullets.fromJson(
            json['feature_bullets'] as Map<String, dynamic>,
          )
        : null;
    id = json['id'] as int;
    mainImage = json['main_image'] as String;
    mapWidget = json['mapWidget'] as String;
    neighbourhood = json['neighbourhood'] as String;
    price = json['price'] != null
        ? Price.fromJson(json['price'] as Map<String, dynamic>)
        : null;
    rating = json['rating'] as double;
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review.add(Review.fromJson(v as Map<String, dynamic>));
      });
    }
    rooms = json['rooms'] != null
        ? Rooms.fromJson(json['rooms'] as Map<String, dynamic>)
        : null;
    starRating = json['starRating'] as int;
    title = json['title'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['checkIn'] = checkIn;
    data['checkOut'] = checkOut;
    data['city'] = city;
    data['description'] = description;
    data['destinationId'] = destinationId;
    if (featureBullets != null) {
      data['feature_bullets'] = featureBullets.toJson();
    }
    data['id'] = id;
    data['main_image'] = mainImage;
    data['mapWidget'] = mapWidget;
    data['neighbourhood'] = neighbourhood;
    if (price != null) {
      data['price'] = price.toJson();
    }
    data['rating'] = rating;
    if (review != null) {
      data['review'] = review.map((v) => v.toJson()).toList();
    }
    if (rooms != null) {
      data['rooms'] = rooms.toJson();
    }
    data['starRating'] = starRating;
    data['title'] = title;
    return data;
  }
}

class FeatureBullets {
  List<String> mainAmenities;
  List<String> whatIsAround;

  FeatureBullets({this.mainAmenities, this.whatIsAround});

  FeatureBullets.fromJson(Map<String, dynamic> json) {
    mainAmenities = (json['Main amenities'] as List).cast<String>();
    whatIsAround = (json['What is around'] as List).cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Main amenities'] = mainAmenities;
    data['What is around'] = whatIsAround;
    return data;
  }
}

class Price {
  int beforePrice;
  String currency;
  int currentPrice;
  bool discounted;
  int savingsAmount;
  int savingsPercent;

  Price(
      {this.beforePrice,
      this.currency,
      this.currentPrice,
      this.discounted,
      this.savingsAmount,
      this.savingsPercent});

  Price.fromJson(Map<String, dynamic> json) {
    beforePrice = json['before_price'] as int;
    currency = json['currency'] as String;
    currentPrice = json['current_price'] as int;
    discounted = json['discounted'] as bool;
    savingsAmount = json['savings_amount'] as int;
    savingsPercent = json['savings_percent'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['before_price'] = beforePrice;
    data['currency'] = currency;
    data['current_price'] = currentPrice;
    data['discounted'] = discounted;
    data['savings_amount'] = savingsAmount;
    data['savings_percent'] = savingsPercent;
    return data;
  }
}

class Review {
  String id;
  String name;
  double rating;
  String review;
  String title;

  Review({this.id, this.name, this.rating, this.review, this.title});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    rating = json['rating'] as double;
    review = json['review'] as String;
    title = json['title'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rating'] = rating;
    data['review'] = review;
    data['title'] = title;
    return data;
  }
}

class Rooms {
  NameOfRoom nameOfRoom;

  Rooms({this.nameOfRoom});

  Rooms.fromJson(Map<String, dynamic> json) {
    nameOfRoom = json['Name of Room'] != null
        ? NameOfRoom.fromJson(json['Name of Room'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (nameOfRoom != null) {
      data['Name of Room'] = nameOfRoom.toJson();
    }
    return data;
  }
}

class NameOfRoom {
  String name;
  int price;
  int maxOccupants;
  int roomsAvailable;

  NameOfRoom({this.name, this.price, this.maxOccupants, this.roomsAvailable});

  NameOfRoom.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    price = json['price'] as int;
    maxOccupants = json['maxOccupants'] as int;
    roomsAvailable = json['roomsAvailable'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['maxOccupants'] = maxOccupants;
    data['roomsAvailable'] = roomsAvailable;
    return data;
  }
}
