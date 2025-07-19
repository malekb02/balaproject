
class AppFirebaseException implements Exception{


  final String code;
  AppFirebaseException(this.code);

  String get message{
    switch(code){
      case 'unknown':
        return'an unknown firebase error occured';
      case 'invalid-custom-token':
        return'The custom token format is incurrecte';
      default:
        return 'Oops Something is wrong in firebase ';
    }
  }

}