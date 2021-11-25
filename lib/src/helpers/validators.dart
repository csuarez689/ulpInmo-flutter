String? validateEmail(String? value) {
  value = value ?? '';

  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) ? null : "Ingresa un correo electrónico valido";
}

String? validateBetween(String? value, {int max = 20, int min = 4}) {
  value = value ?? '';
  return value.length < min || value.length > max ? "El campo debe tener entre $min y $max caracteres" : null;
}

String? validateNumberBetween(num value, {num max = double.infinity, num min = 0}) {
  return value < min || value > max ? "El campo debe ser un número entre $min y $max" : null;
}

bool validateSame(String? value, String? value2) {
  value = value ?? '';
  value2 = value2 ?? '';
  return value == value2;
}
