import 'dart:convert';

import 'package:flutter/foundation.dart';

class Store {
  final String id; // store_id
  final String name;
  final String contact;
  final String timeOpen;
  final String timeClose;
  final String description;
  final double latitude;
  final double longtitude;
  final String userId;
  final String image;

  Store({
    required this.id,
    required this.name,
    required this.contact,
    required this.timeOpen,
    required this.timeClose,
    required this.description,
    required this.latitude,
    required this.longtitude,
    required this.userId,
    required this.image,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'time_open': timeOpen,
      'time_close': timeClose,
      'description': description,
      'latitude': latitude,
      'longitude': longtitude,
      'user_id': userId,
      'image': image,
    };
  }

  factory Store.fromJSON(Map<String, dynamic> json) {
    return Store(
      id: json['id'] as String,
      name: json['name'] as String,
      contact: json['contact'] as String,
      timeOpen: json['time_open'] as String,
      timeClose: json['time_close'] as String,
      description: json['description'] as String,
      latitude: json['latitude'] as double,
      longtitude: json['longtitude'] as double,
      userId: json['user_id'] as String,
      image: json['image'] as String,
    );
  }

  @override
  String toString() {
    return 'Store{id: $id, name: $name, contact: $contact, timeOpen: $timeOpen, '
        'timeClose: $timeClose, description: $description, latitude: $latitude, '
        'longitude: $longtitude, userId: $userId}';
  }
}
