import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink){
        final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@\.!#$%&*+/?^`{|}~]+$');
        if (validCharacters.hasMatch(email)) {
          sink.add(email);
        } else if (email.length <= 0) {
          sink.addError('Enter a valid email');
        }
      });

  final validatePassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
        if (password.length < 6 ) {
          sink.addError('Password must be at least 6 characters');
        } else if (password.length >= 6 ) {
          sink.add(password);
        }
      });


}