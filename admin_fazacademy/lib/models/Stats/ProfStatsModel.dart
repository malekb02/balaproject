import 'package:cloud_firestore/cloud_firestore.dart';

class ProfStatsModel {
  final String id;
  final int classAvDur ;
  final int numberClasses ;
  final int numberClassValide ;
  final int numberNegRem ;
  final int numberPosRem ;
  final int numRem ;
  final int sommeDA ;

  ProfStatsModel({
    required this.classAvDur,
    required this.numberClasses,
    required this.id,
    required this.numberClassValide,
    required this.numberNegRem,
    required this.numberPosRem,
    required this.numRem,
    required this.sommeDA,
  });
  static ProfStatsModel empty() => ProfStatsModel(
    id: "",
    classAvDur : 0,
    numberClasses: 0,
    numberClassValide: 0,
    numberNegRem: 0,
    numberPosRem: 0,
    numRem: 0,
    sommeDA: 0,
  );
  Map<String, dynamic> toJson() {
    return {
      'classDurAv': classAvDur,
      'classNum' : numberClasses,
      'classValide' : numberClassValide,
      'numNegRem' : numberNegRem,
      'numPosRem' : numberPosRem,
      'numRema' : numRem,
      'sommeDA' : sommeDA,
    };
  }

  factory ProfStatsModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProfStatsModel(
      id: snapshot.id,
      classAvDur: data['classDurAv'] ?? '',
      numberClasses: data['classNum'],
      numberClassValide: data['classValide'],
      numberNegRem: data['numNegRem'],
      numberPosRem: data['numPosRem'],
      numRem: data['numRema'],
      sommeDA: data['sommeDA'],
    );
  }
}
