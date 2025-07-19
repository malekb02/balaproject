import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_english_course/utils/formatters/formatter.dart';
import 'package:get/get.dart';

class AdminModel {

  final String id;
   String nom;
   String prenom;
  final String numero;
   String email;
  final String username;
  final String position;
  static RxBool isAdmin = false.obs ;
  AdminModel( {
    required this.id,
    required  this.nom,
    required  this.prenom,
    required  this.numero,
    required  this.email,
    required  this.username,
    required  this.position,
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
  static AdminModel empty() => AdminModel(
    id: "",
    nom : "",
    prenom: "",
    numero: "",
    email: "",
    username: "",
    position: "",
  );



  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'numero': numero,
      'email': email,
      'username': email,
      'position': position,
    };
  }

  factory AdminModel.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      if(data['position'] == "super"){
        AdminModel.isAdmin = true.obs;
      }
      return AdminModel(
        id: snapshot.id,
        nom: data['nom'],
        prenom: data['prenom'],
        numero: data['numero'],
        email: data['email'],
        username: data['username'],
        position: data['position'] ,
      );
    }else{
      return AdminModel.empty();
    }
  }
}
