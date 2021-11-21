String? validateEmail(String? value) {
  value = value ?? '';

  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) ? null : "Ingresa un correo electrónico valido";
}

String? validateBetween(String? value, [int min = 4, int max = 20]) {
  value = value ?? '';
  return value.length < min || value.length > max ? "La contraseña debe tener entre $min y $max caracteres" : null;
}

bool validateSame(String? value, String? value2) {
  value = value ?? '';
  value2 = value2 ?? '';
  return value == value2;
}
