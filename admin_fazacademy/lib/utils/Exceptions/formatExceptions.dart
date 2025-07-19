
class AppFormatException implements Exception{

  final String message;
  const AppFormatException ([this.message = 'An unexpected format error , Please check your input']);


  factory AppFormatException.fromMessage(String message){
    return AppFormatException(message);
  }

  String get formattedMessage => message;

  factory AppFormatException.fromCode(String code){
    switch(code){
      case 'invalid-email-format':
        return const AppFormatException('The email address format is invalid , please enter a valid email.');
      case 'invalid-phone-number-format':
        return const AppFormatException('The provided phone number format is invalid , please inter a valid phone number');
      case 'invalid-date-format':
        return const AppFormatException('The provided date format is invalid , please inter a valid date');
      case 'invalid-url-format':
        return const AppFormatException('The provided URL is invalid , please inter a valid URL');
      case 'invalid-numeric-format':
        return const AppFormatException('The input should a valid numeric format.');
      default:
        return const AppFormatException();
    }
  }

}