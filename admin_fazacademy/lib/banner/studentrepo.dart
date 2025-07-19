import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/eleve/parentmodel.dart';
import 'package:flutter_english_course/models/service/ServiceModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Exceptions/FirebaseAuthExceptions.dart';
import '../../../utils/Exceptions/firebaseException.dart';
import '../../../utils/Exceptions/formatExceptions.dart';
import '../../models/banner/BannerModel.dart';
import '../../utils/Exceptions/platform exceptions.dart';




class StudentRepository extends GetxController{
  static StudentRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<EleveModel>> fetchAllStudents() async{
    try{
      final result = await _db.collection("eleve").get();
      return result.docs.map((document) => EleveModel.fromSnapshot(document)).toList();
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
  Future<List<Parentmodel>> fetchAllParents() async{
    try{
      final result = await _db.collection("Parent").get();
      return result.docs.map((document) => Parentmodel.fromSnapshot(document)).toList();
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
  Future<void> updateSingleField(String id,json) async{
    try{
      await _db.collection("eleve").doc(id).update(json);

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
  Future<void> updateSingleFieldParent(String id,json) async{
    try{
      await _db.collection("Parent").doc(id).update(json);

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
  Future<void> addNewParent(Parentmodel model) async{
    try{
      await _db.collection("Parent").doc().set(model.toJson());
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
  Future<void> addNewStudent(EleveModel model,Parentmodel parent) async{
    try{
      await _db.collection("eleve").doc(model.id).set(model.toJson());
      await _db.collection("Parent").doc(parent.id).update({"eleve" : FieldValue.arrayUnion([model.id])});
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
  Future<void> removeClassRecord(String classID) async{
    try{
      await _db.collection('eleve').doc(classID).delete();
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
  Future<void> removeParentRecord(String ParentID) async{
    try{
      /*await _db.collection('Parent').doc(ParentID).delete();
      await _db.collection('eleve').where("");
      final parentDoc = await _db.collection('Parent').doc(ParentID).get();
      if (!parentDoc.exists) return;
      final List<dynamic> studentIds = parentDoc.data()?['eleve'] ?? [];
      for (final studentId in studentIds) {
        // Delete classes
        final classSnapshot = await _db
            .collection('classes')
            .where('studentId', isEqualTo: studentId)
            .get();
        for (final doc in classSnapshot.docs) {
          await doc.reference.delete();
        }

        // Delete remarks
        final remarksSnapshot = await _db
            .collection('remarks')
            .where('eleve', isEqualTo: studentId)
            .get();
        for (final doc in remarksSnapshot.docs) {
          await doc.reference.delete();
        }

        // Delete the student document
        await _db.collection('students').doc(studentId).delete();
      }
*/


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