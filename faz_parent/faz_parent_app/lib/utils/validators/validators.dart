

class AppValidator{


  static String? validateEmptyText(String? fieldName,String? value){
    if(value == null || value.isEmpty){
      return "$fieldName is required.";
    }else{
      return null;
    }
  }
  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return "Phone Number is required.";
    }

    final phoneRegExp = RegExp(r'^\d{10}$');

    if(!phoneRegExp.hasMatch(value)){
      return "Invalide phone number format (10 digits required)";
    }

    return null;
  }
  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)){
      return 'Invalid Email Address';
    }
    return null;
  }
  static String? validateHoures(String? value){
    if(value == null || value.isEmpty){
      return 'عدد الساعات الزامي';
    }

    final emailRegExp = RegExp(r'^(0|[1-9][0-9]*)$');

    if (!emailRegExp.hasMatch(value)){
      return 'عدد الساعات يجب أن يكون رقم';
    }
    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required';
    }

    if(value.length < 6){
      return'Pasword must be at least 6 caracters long';
    }

    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least one Uppercase letter';
    }
    
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number';
    }

    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'Pasword must contain at least one special caracter';
    }
    return null;
    

  }

}