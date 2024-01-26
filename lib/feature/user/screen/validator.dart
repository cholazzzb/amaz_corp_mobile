String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'username is required';
  }
  if (value.length < 5) {
    return 'username must at least 5 characters';
  }

  return null;
}
