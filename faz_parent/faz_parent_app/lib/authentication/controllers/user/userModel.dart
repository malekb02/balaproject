import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../utils/Loaders/AppLoaders.dart';
import '../../../utils/formatters/formatter.dart';

class UserModel {
   String id,
      firstName,
      lastName,
      userName,
      email,
      phonenumber,
      profilePicture;
  static  RxBool isAdmin = false.obs ;
  static  RxBool isEditeMode = false.obs ;



  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.phonenumber,
      required this.profilePicture});

  String get fullname => '$firstName $lastName';

  String get formattedPhoneNumber =>
      AppFormatter.formatPhoneNumber(phonenumber);

  static List<String> nameParts(fullname) => fullname.split(" ");

  static String generateUserName(fullname) {
    List<String> nameParts = fullname.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = '$firstName$lastName';
    String userNameWithPrefix = "cwt_$camelCaseUserName";
    return userNameWithPrefix;
  }

  static UserModel empty() => UserModel(
      id: "",
      firstName: "",
      lastName: "",
      userName: "",
      email: "",
      phonenumber: "",
      profilePicture: "");

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phonenumber,
      'ProfilePicture': profilePicture,
    };
  }


  factory UserModel.fromSnapshot (DocumentSnapshot<Map<String, dynamic>> document){

    if (document.data() != null) {
      final data = document.data();
      return UserModel(
          id: document.id,
          firstName: data!['FirstName'],
          lastName: data!["LastName"],
          userName: data!['UserName'],
          email: data!["Email"],
          phonenumber: data!["PhoneNumber"],
          profilePicture: data!["ProfilePicture"]
      );
    }else{
      return UserModel.empty();
    }
  }

}
