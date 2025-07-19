import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/models/travaux.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Exceptions/FirebaseAuthExceptions.dart';
import '../../../utils/Exceptions/firebaseException.dart';
import '../../../utils/Exceptions/formatExceptions.dart';
import '../../models/banner/BannerModel.dart';
import '../../utils/Exceptions/platform exceptions.dart';
import 'AuthenticationRepository.dart';




class TraveauxRepository extends GetxController{
  static TraveauxRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<TravauxModel>> fetchTrav() async{
    try{
      final result = await _db.collection("travaux").where('prof',isEqualTo: AuthenticationRepository.instance.authUser!.uid).get();
      return result.docs.map((document) => TravauxModel.fromSnapshot(document)).toList();
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
  Future<void> workdone(String id,json) async{
    try{
      await _db.collection("travaux").doc(id).update(json);

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