class MyTextFieldValidators {
  static String? notEmptyValidator(String? value) {
    if (value == null || value.trim().isEmpty || value.trim() != '' ) {
      return 'To pole nie może być puste';
    }
    return null; // null oznacza, że wartość jest poprawna
  }

  static String? numberNotEmptyValidator(String? value) {
    if (value == null || value.trim().isEmpty || value.trim() !='') {
      return 'To pole nie może być puste';
    }
    if (double.tryParse(value) == null) {
      return 'Wartość musi być liczbą';
    }
    return null; // null oznacza, że wartość jest poprawna
  }
}
