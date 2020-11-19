import 'package:flutter/cupertino.dart';

class NewReviews {
  double rating;
  List<Review> reviews;

  NewReviews({@required this.rating, @required this.reviews});

  NewReviews.fromJson(Map<String, dynamic> json) {
    rating = json['rating'] as double;
    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((review) {
        reviews.add(Review.fromJson(review as Map<String, dynamic>));
      });
    }
  }
}

class Review {
  String id;
  String name;
  double rating;
  String review;
  String title;

  Review({
    this.id,
    this.name,
    @required this.rating,
    @required this.review,
    @required this.title,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    review = json['review'] as String;
    rating = json['rating'] as double;
    title = json['title'] as String;
  }

  Map<String, dynamic> toMap() {
    return {
      'review': review,
      'rating': rating.toInt(),
      'title': title,
    };
  }
}
