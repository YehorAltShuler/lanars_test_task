// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Feed {
  final String photographerName;
  final String alt;
  final String originalPictureUrl;
  final String smallPictureUrl;
  final String avgColor;

  Feed({
    required this.photographerName,
    required this.alt,
    required this.originalPictureUrl,
    required this.smallPictureUrl,
    required this.avgColor,
  });

  Color get avgColorAsColor {
    final hexColor = int.parse(avgColor.replaceFirst('#', ''), radix: 16);
    return Color(0xFF000000 | hexColor);
  }

  Feed copyWith({
    String? photographerName,
    String? alt,
    String? originalPictureUrl,
    String? smallPictureUrl,
    String? avgColor,
  }) {
    return Feed(
      photographerName: photographerName ?? this.photographerName,
      alt: alt ?? this.alt,
      originalPictureUrl: originalPictureUrl ?? this.originalPictureUrl,
      smallPictureUrl: smallPictureUrl ?? this.smallPictureUrl,
      avgColor: avgColor ?? this.avgColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photographerName': photographerName,
      'alt': alt,
      'originalPictureUrl': originalPictureUrl,
      'smallPictureUrl': smallPictureUrl,
      'avgColor': avgColor,
    };
  }

  factory Feed.fromMap(Map<String, dynamic> map) {
    final src = map['src'] as Map<String, dynamic>;
    return Feed(
      photographerName: map['photographer'] as String,
      alt: map['alt'] as String,
      originalPictureUrl: src['original'] as String,
      smallPictureUrl: src['small'] as String,
      avgColor: map['avg_color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Feed.fromJson(String source) =>
      Feed.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Feed(photographerName: $photographerName, alt: $alt, originalPictureUrl: $originalPictureUrl, smallPictureUrl: $smallPictureUrl, avgColor: $avgColor)';
  }

  @override
  bool operator ==(covariant Feed other) {
    if (identical(this, other)) return true;

    return other.photographerName == photographerName &&
        other.alt == alt &&
        other.originalPictureUrl == originalPictureUrl &&
        other.smallPictureUrl == smallPictureUrl &&
        other.avgColor == avgColor;
  }

  @override
  int get hashCode {
    return photographerName.hashCode ^
        alt.hashCode ^
        originalPictureUrl.hashCode ^
        smallPictureUrl.hashCode ^
        avgColor.hashCode;
  }
}
