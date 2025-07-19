


class AppPlatformException implements Exception{


  final String code;
  AppPlatformException(this.code);

  String get message{
    switch(code){

      default:
        return 'Oops Platform exception &&&&&';
    }
  }

}