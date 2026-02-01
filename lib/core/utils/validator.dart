String? validator(InputType inputType, String? value, String? passwordValue) {
  if (value == null || value.isEmpty) {
    return 'Requied field';
  } else {
    var text = value.trim();

    switch (inputType) {
      case InputType.email:
        if (!emailRegex.hasMatch(text)) {
          return 'Invalid email';
        }
      case InputType.password:
        if (text.isEmpty) {
          return 'Password cannot be all spaces';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
      case InputType.name:
        if (text.length < 3) {
          return 'Name is too short';
        }
      case InputType.confirmPassword:
        if (passwordValue == null || passwordValue.isEmpty) {
          return 'Please enter password first';
        }
        if (value != passwordValue) {
          return 'Passwords do not match';
        }
    }
  }
  return null;
}

final emailRegex = RegExp(r'^[\w\.\-+]+@([\w-]+\.)+[\w-]{2,4}$');

enum InputType { email, password, confirmPassword, name }
