import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_course/controllers/controllers/profmodel.dart';
import 'package:flutter_english_course/models/prof/adminModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Exceptions/FirebaseAuthExceptions.dart';
import '../../../utils/Exceptions/firebaseException.dart';
import '../../../utils/Exceptions/formatExceptions.dart';
import '../../banner/AuthenticationRepository.dart';
import '../../models/banner/BannerModel.dart';
import '../../utils/Exceptions/platform exceptions.dart';




class Profrepository extends GetxController{
  static Profrepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> saveProfModel(ProfModel prof) async{
    try{
      await _db.collection("prof").doc(prof.id).set(prof.toJson());
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
  Future<List<ProfModel>> fetchAllProfs() async{
    try{
      final documentSnapshot =  await _db.collection("prof").get();
      return documentSnapshot.docs.map((document) => ProfModel.fromSnapshot(document)).toList();
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
  Future<void> updateProfDetails(ProfModel Prof) async{
    try{
      await _db.collection("prof").doc(Prof.id).update(Prof.toJson());

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
  Future<void> updateSingleField(String id,Map<String,dynamic> json) async{
    try{
      await _db.collection("prof").doc(id).update(json);

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
}