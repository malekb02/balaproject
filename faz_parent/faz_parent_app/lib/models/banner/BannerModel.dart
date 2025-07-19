import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageURL;
  final String id;
  final String title ;
  final String desc ;
  final bool active;

  BannerModel({
    required this.title,
    required this.desc,
    required this.id,
    required this.imageURL,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      'imageURL': imageURL,
      'title' : title,
      'desc' : desc,
      'Active': active
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
        id: snapshot.id,
        imageURL: data['imageURL'] ?? '',
        title: data['title'],
        desc: data['desc'],
        active: data['Active'] ?? false
    );
  }
}
