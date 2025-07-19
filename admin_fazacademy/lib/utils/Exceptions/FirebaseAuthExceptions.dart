
class AppFirebaseAuthException implements Exception{


  final String code;
  AppFirebaseAuthException(this.code);

  String get message{
    switch(code){
      case 'email-already-use':
        return'The email addresse is already registered , please use different email';
      case 'invalid-email':
        return'The email addresse provided is invalid, Please enter a valid Email';
      case 'weak-password':
        return'The password is too weak. please choose a stronger password';
      case 'user-disabled':
        return'This user has been Disabled. please contact support for assistance';
      case 'user-not-found':
        return'Invalid login details. User not found';
      case 'wrong-password':
        return'Incorrect password. Please check your password and try again';
      case 'invalid-verification-code':
        return'Invalid verification code. Please enter a valid code';
      case 'invalid-verification-id':
        return'Invalid verification ID. Please request a new verification code';
      case 'quota-exceeded':
        return'Quota exceeded. Please try again later';
      case 'email-already-exists':
        return'This email address already exists. Please use different email address ';
      case 'provider-already-linked':
        return'The account is already linked to another provider';
      case 'requires-recent-login':
        return'This operation is sensitive and requires recent authentication. Please login again.';
      case 'credential-already-in-use':
        return'This credential already associated with a different user account.';
      case 'user-mismatch':
        return'The supplied credentials do not correspond to the previously signed user';
      case 'account-exists-with-different-credentials':
        return'an account already exists with the same email but with different sign-in credentials ';
      case 'operation-not-allowed':
        return'This operation is not allowed. Contact   support for assistance';
      case 'expired-action-code':
        return'The action code has expired.  Please request a new action code';
      case 'invalid-action-code':
        return'The action code is invalid. Please check the code and try again';
      case 'missing-action-code':
        return'The action code is missing. Please provide a valid action code';
      case 'user-token-expired':
        return'The user\'s token has expired. and authentification is required. please login again';
      case 'user-not-found':
        return'No user found for the given Email and UID';
      case 'invalid-credential':
        return'The supplied credential is malformed or has expired';
      case 'wrong-password':
        return'The password is invalid. Please check your password and try again';
      case 'user-token-revoked':
        return'The user\'s token has been revoked. Please sign in again';
      case 'invalid-message-payload':
        return'The email template verification message payload is invalid';
      case 'email-already-in-use':
        return'ce mail est deja utilisé';
      default:
        return 'Oops Something is wrong , try again';
    }
  }

}