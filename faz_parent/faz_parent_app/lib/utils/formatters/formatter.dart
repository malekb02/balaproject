import 'package:intl/intl.dart';



class AppFormatter {


  static String formatDate(DateTime? date){
      date ??= DateTime.now();
      return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formateCurrency(double amount){
    return NumberFormat.currency(locale: 'en-DZ',symbol: 'DZD').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber){
      return '${phoneNumber.substring(0,2)} ${phoneNumber.substring(3,10)}';
  }




}