import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/navigation_menu.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../utils/Exceptions/FirebaseAuthExceptions.dart';
import '../../../utils/Exceptions/firebaseException.dart';
import '../../../utils/Exceptions/formatExceptions.dart';
import '../../../utils/Exceptions/platform exceptions.dart';
import '../../../utils/Loaders/AppLoaders.dart';
import '../../authentication/screens/SignUp/verify_email.dart';
import '../../authentication/screens/login/login.dart';
import '../../authentication/screens/onboading/onboarding.dart';


class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();


  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final localStorage = GetStorage();
  User? get authUser => _auth.currentUser;
  @override
  void onInit(){
    FlutterNativeSplash.remove();
    sreenRedirect();
  }

  sreenRedirect() async{
    final user = _auth.currentUser;
    //Get.put(AdminController());
    if(user != null){
      if(user.emailVerified){
        Get.offAll(()=> NavigationMenu());
      }else{
       Get.to(()=> VerifyEmailScreen(email: _auth.currentUser?.email ?? "",));
      }
    }else{
      ///local storage
      deviceStorage.writeIfNull("isFirstTime",true);
      Get.offAll(()=> LoginScreen());
    }
  }

  /*------------------------------Email and password sign-in--------------------------------*/

  ///[Email auth] - Sign In
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: "aggomehdi79@gmail.com", password: "102030mahdiHH%");
    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException().message;
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }
  ///[Email auth] - Register

  Future<UserCredential> registerWithEmailAndPassword(String email,String password) async{
    try{
      return await _auth.createUserWithEmailAndPassword(email: email,password:password);

    }on FirebaseAuthException catch (e){
      throw AppFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e){
      throw AppFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw AppFormatException().message;
    }on PlatformException catch(e){
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went Wrong , please try again";
    }
  }
  /// Email verification

  Future<void> sendEmailVerification()async{
    try {
      _auth.currentUser?.sendEmailVerification();
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

  /// Reauthenticate user
  Future<void> reAuthenticateWithEmailAndPassword(String email,String password)async{
    try{
      AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credentials);
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
  /// Forget password
  Future<void> resetPassword(String email)async{
    try {
      _auth.sendPasswordResetEmail(email: email);
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
  /*-------------------------Federate  identity & social  sign-in--------------------------*/
  /// Google
  Future<UserCredential> signInWithGoogle()async{
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
      final credentials = await GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await _auth.signInWithCredential(credentials);
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
  /// Facebook

  /*-------------------------end--------------------------*/
  Future<void> logout() async{
    try{
      localStorage.write("IS_ADMIN", false);
     // Get.offAll(LoginScreen());
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      await _auth.currentUser!.delete();


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
  /// Remove  user auth  and firebase account

  Future<void> deleteAccount()async{
    try{
     // await UserRepositoty.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser!.delete();
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

