import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/utils/formatters/formatter.dart';
import 'package:get/get.dart';

class ParentModel {

  final String id;
  String nom;
  String prenom;
  final String numero;
  String email;
  final List<String> ListEleve;

  ParentModel( {
    required this.id,
    required  this.nom,
    required  this.prenom,
    required  this.ListEleve,
    required  this.numero,
    required  this.email,
  });

  String get fullname => '$nom $prenom';
  String get formattedPhoneNumber =>
      AppFormatter.formatPhoneNumber(numero);
  static List<String> nameParts(fullname) => fullname.split(" ");

  static String generateUserName(fullname) {
    List<String> nameParts = fullname.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = '$firstName$lastName';
    String userNameWithPrefix = "fazParent_$camelCaseUserName";
    return userNameWithPrefix;
  }
  static ParentModel empty() => ParentModel(
    id: "",
    nom : "",
    prenom: "",
    ListEleve :[],
    numero: "",
    email: "",
  );



  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'numero': numero,
      'eleve': ListEleve,
      'email': email,
      'username': email,
    };
  }

  factory ParentModel.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return ParentModel(
        id: snapshot.id,
        nom: data['nom'],
        prenom: data['prenom'],
        numero: data['numero'],
        ListEleve: List<String>.from(data['eleve']),
        email: data['email'],
      );
    }else{
      return ParentModel.empty();
    }
  }
}
