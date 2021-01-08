String emailValidator(String email) {
  if (email.isEmpty) {
    return 'Ingrese su correo electrónico';
  }

  if (!RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
      .hasMatch(email)) {
    return 'Ingrese un correo electrónico valido';
  }

  return null;
}

String passwordValidator(String password) {
  if (password.isEmpty) {
    return 'Ingrese su contraseña';
  }

  if (password.length < 6) {
    return 'Su contraseña debe contener al menos 6 caracteres';
  }

  return null;
}
