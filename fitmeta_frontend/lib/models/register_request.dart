// lib/models/register_request.dart
class RegisterRequest {
  final String email;
  final String nome;
  final String sobrenome;
  final String senha;
  final String tipoUsuario; // Ex: "Personal" ou "Atleta"

  RegisterRequest({
    required this.email,
    required this.nome,
    required this.sobrenome,
    required this.senha,
    required this.tipoUsuario,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'nome': nome,
      'sobrenome': sobrenome,
      'senha': senha,
      'tipoUsuario': tipoUsuario,
    };
  }
}