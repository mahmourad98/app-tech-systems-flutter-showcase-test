class Credentials {
  final String email;
  final String password;

  Credentials({
    this.email = "",
    this.password = "",
  });

  Credentials copyWith({
    String? email,
    String? password,
  }) => Credentials(
    email: email ?? this.email,
    password: password ?? this.password,
  );

  bool isValid() => email.trim().isNotEmpty && password.trim().isNotEmpty && password.length >= 8;
}
