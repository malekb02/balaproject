import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/formatters/formatter.dart';

class EleveModel {

  final String id;
  final String nom;
  final String prenom;
  final DateTime dateInsc;
  final DateTime dateNes;
  final String numParent;
  final String niveauSco;
  final int age;
  final String noteImp;
  final String adresse;
  final String email;
  final String username;
  final List<Map<String,dynamic>> service;

  EleveModel( {
    required this.id,
    required  this.nom,
    required  this.prenom,
    required  this.dateInsc,
    required  this.dateNes,
    required  this.numParent,
    required  this.niveauSco,
    required  this.age,
    required  this.noteImp,
    required  this.adresse,
    required  this.service,
    required  this.email,
    required  this.username,
  });

  String get fullname => '$nom $prenom';
  String get formattedPhoneNumber =>
      AppFormatter.formatPhoneNumber(numParent);

  static String generateUserName(fullname) {
    List<String> nameParts = fullname.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = '$firstName$lastName';
    String userNameWithPrefix = "fazélève_$camelCaseUserName";
    return userNameWithPrefix;
  }
  static EleveModel empty() => EleveModel(
      id: "",
      nom : "",
      prenom: "",
      dateInsc : DateTime.utc(2024),
      dateNes : DateTime.utc(2024),
      numParent : "",
      age : 0,
      noteImp : "",
      adresse :"",
      service :[],
      niveauSco: "",
      email :"",
      username :"",
  );

  Map<String, dynamic> toJson() {
    return {
      'adresse': adresse,
      'age': age,
      'dateInsc': dateInsc,
      'dateNes': dateNes,
      'nom': nom,
      'prenom': prenom,
      'noteImp': noteImp,
      'numParent': numParent,
      'niveauSco': niveauSco,
      'service': service,
      'email': email,
      'username': username,
    };
  }
  static List fromFireBaseToLocal (Map<String,dynamic> Data){
    List list=  Data.entries.toList();
    final ListService = <Map<String,dynamic>>[];
    for(int i =0; i<list.length;i++) {
      ListService.add({"service" : list[i]["sevice"],"dateInsc" : list[i]["dateInsc"]});
    }
    return ListService;
  }
  factory EleveModel.fromSnapshot(DocumentSnapshot snapshot) {

      if (snapshot.data() != null) {
        final data = snapshot.data() as Map<String, dynamic>;
        return EleveModel(
          id: snapshot.id,
          adresse: data['adresse'] ?? '',
          age: data['age'] ?? '',
          dateInsc: data['dateInsc'].toDate(),
          dateNes: data['dateNes'].toDate(),
          nom: data['nom'],
          prenom: data['prenom'],
          noteImp: data['noteImp'],
          niveauSco: data['niveauSco'],
          numParent: data['numParent'],
          service: List<Map<String,dynamic>>.from(data['service']),
          email: data['email'],
          username: data['username'],
        );
      }else{
        return EleveModel.empty();
      }
  }
}
