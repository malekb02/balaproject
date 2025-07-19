


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_course/authentication/controllers/user/userModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../banner/AuthenticationRepository.dart';
import '../../../models/prof/adminModel.dart';
import '../../../utils/Exceptions/FirebaseAuthExceptions.dart';
import '../../../utils/Exceptions/firebaseException.dart';
import '../../../utils/Exceptions/formatExceptions.dart';
import '../../../utils/Exceptions/platform exceptions.dart';
import '../../../utils/Loaders/AppLoaders.dart';

class UserRepositoty extends GetxController{
  static UserRepositoty get  instance => Get.find();


  final FirebaseFirestore _db = FirebaseFirestore.instance;


  ///Function to save user data to firestore

  Future<void> saveUserModel(AdminModel user) async{
    try{
      await _db.collection("prof").doc(user.id).set(user.toJson());
    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException();
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }


  ///Function  to fetch user details based on ID
  Future<AdminModel> fetchUserDetails() async{
    try{
     final documentSnapshot =  await _db.collection("prof").doc(AuthenticationRepository.instance.authUser!.uid).get();
     if(documentSnapshot.exists){
        return AdminModel.fromSnapshot(documentSnapshot);
      }else{
        return AdminModel.empty();
      }
    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException();
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }
  Future<List<AdminModel>> fetchAllUsers() async{
    try{
      final documentSnapshot =  await _db.collection("prof").get();
      return documentSnapshot.docs.map((document) => AdminModel.fromSnapshot(document)).toList();
    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException();
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }
  ///Function to update user data  in firestore
  Future<void> updateUserDetails(AdminModel updateUser) async{
    try{
      await _db.collection("prof").doc(updateUser.id).update(updateUser.toJson());

    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException();
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }

  /// Update any field in specific user collection
  Future<void> updateSingleField(Map<String,dynamic> json) async{
    try{
      await _db.collection("prof").doc(AuthenticationRepository.instance.authUser!.uid).update(json);

    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException();
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }
  /// Function to remove user data from fiestore

  Future<void> removeUserRecord(String userId) async{
    try{
      final documentSnapshot =  await _db.collection("prof").doc(userId).delete();
    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException();
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }
  Future<String> uploadImage(String path, XFile image) async {
    try{

      final ref =FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;


    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException();
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }

  Future<void> deleteProfileImage(String path,String url) async {
    try{
      final ref = await FirebaseStorage.instance.refFromURL(url);
      await FirebaseStorage.instance.ref(path).child(ref.name).delete();
    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException();
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }
}

