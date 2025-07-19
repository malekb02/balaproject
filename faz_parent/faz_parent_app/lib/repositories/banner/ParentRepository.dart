import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/parent/parentModel.dart';
import 'package:flutter_english_course/models/prof/profModel.dart';
import 'package:flutter_english_course/repositories/banner/AuthenticationRepository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Exceptions/FirebaseAuthExceptions.dart';
import '../../../utils/Exceptions/firebaseException.dart';
import '../../../utils/Exceptions/formatExceptions.dart';
import '../../models/banner/BannerModel.dart';
import '../../utils/Exceptions/platform exceptions.dart';




class ParentRepository extends GetxController{
  static ParentRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> saveParentModel(ParentModel Parent) async{
    try{
      await _db.collection("Parent").doc(Parent.id).set(Parent.toJson());
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

  Future<ParentModel> fetchParentDetails() async{
    try{
      final documentSnapshot =  await _db.collection("Parent").doc(AuthenticationRepository.instance.authUser!.uid).get();
      if(documentSnapshot.exists){
          return ParentModel.fromSnapshot(documentSnapshot);
      }else{
        return ParentModel.empty();
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
  Future<EleveModel> fetchEleve(String id) async{
    try{
      final documentSnapshot =  await _db.collection("eleve").doc(id).get();
        return EleveModel.fromSnapshot(documentSnapshot);
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

  Future<void> updateParentDetails(ParentModel updateUser) async{
    try{
      await _db.collection("Parent").doc(updateUser.id).update(updateUser.toJson());

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
  Future<void> updateSingleField(Map<String,dynamic> json) async{
    try{
      await _db.collection("Parent").doc(AuthenticationRepository.instance.authUser!.uid).update(json);

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
  Future<void> removeProfRecord(String userId) async{
    try{
      final documentSnapshot =  await _db.collection("Parent").doc(userId).delete();
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