import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_english_course/utils/formatters/formatter.dart';
import 'package:get/get.dart';

class Parentmodel {

  final String id;
  String nom;
  String prenom;
  final String numero;
  String email;
  final List<String> hisstudents;
  Parentmodel( {
    required this.id,
    required  this.nom,
    required  this.prenom,
    required  this.numero,
    required  this.email,
    required  this.hisstudents
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
    String userNameWithPrefix = "fazProf_$camelCaseUserName";
    return userNameWithPrefix;
  }
  static Parentmodel empty() => Parentmodel(
    id: "",
    nom : "",
    prenom: "",
    numero: "",
    email: "",
    hisstudents: []
  );



  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'numero': numero,
      'email': email,
      'eleve' : hisstudents
    };
  }

  factory Parentmodel.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return Parentmodel(
        id: snapshot.id,
        nom: data['nom'],
        prenom: data['prenom'],
        numero: data['numero'],
        email: data['email'],
        hisstudents: List<String>.from(data['eleve']),
      );
    }else{
      return Parentmodel.empty();
    }
  }
}
