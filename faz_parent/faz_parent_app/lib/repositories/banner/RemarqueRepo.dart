import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueProf.dart';
import 'package:flutter_english_course/repositories/banner/AuthenticationRepository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Exceptions/FirebaseAuthExceptions.dart';
import '../../../utils/Exceptions/firebaseException.dart';
import '../../../utils/Exceptions/formatExceptions.dart';
import '../../models/banner/BannerModel.dart';
import '../../models/remarqueProf/remarqueIdara.dart';
import '../../utils/Exceptions/platform exceptions.dart';




class RemarqueRepository extends GetxController{
  static RemarqueRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<RemarqueProfModel>> fetchProfRemarques() async{
    try{
      final result = await _db.collection("remarqueProf").where('eleve',isEqualTo: ParentController.instance.selectedStudent.value.id).get();
      return result.docs.map((document) => RemarqueProfModel.fromSnapshot(document)).toList();
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
  Future<List<RemarqueIdaraModel>> fetchIdaraRemarques() async{
    try{
      final result = await _db.collection("remarqueAdmin").where('eleve',isEqualTo: ParentController.instance.selectedStudent.value.id).get();
      return result.docs.map((document) => RemarqueIdaraModel.fromSnapshot(document)).toList();
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