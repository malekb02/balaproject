import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_english_course/utils/formatters/formatter.dart';
import 'package:get/get.dart';

class ProfModel {

  final String id;
   String nom;
   String prenom;
  final String numero;
   String email;
  final String username;
  final List<String> service;
  static  RxBool isAdmin = false.obs ;
  static  RxBool isEditeMode = false.obs ;
  ProfModel( {
    required this.id,
    required  this.nom,
    required  this.prenom,
    required  this.service,
    required  this.numero,
    required  this.email,
    required  this.username,
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
  static ProfModel empty() => ProfModel(
    id: "",
    nom : "",
    prenom: "",
    service :[],
    numero: "",
    email: "",
    username: "",
  );



  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'numero': numero,
      'service': service,
      'email': email,
      'username': email,
    };
  }

  factory ProfModel.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return ProfModel(
        id: snapshot.id,
        nom: data['nom'],
        prenom: data['prenom'],
        numero: data['numero'],
        service: List<String>.from(data['service']),
        email: data['email'],
        username: data['username'],
      );
    }else{
      return ProfModel.empty();
    }
  }
  static List fromFireBaseToLocal (Map<String,dynamic> Data){
    List list=  Data.entries.toList();
    final ListProduct = <String>[];
    for(int i =0; i<list.length;i++) {
      ListProduct.add(list[i].toString());
    }
    return ListProduct;
  }
}
