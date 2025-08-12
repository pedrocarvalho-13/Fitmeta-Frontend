import 'package:fitmeta_frontend/models/login_request.dart';
import 'package:fitmeta_frontend/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _authService =
      AuthService(); // Instância do seu serviço de autenticação
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Ativa o estado de loading
      });

      final request = LoginRequest(
        email: _emailController.text,
        senha: _senhaController.text,
      );

      final loginSuccess = await _authService.login(request);

      setState(() {
        _isLoading = false; // Desativa o estado de loading
      });

      if (loginSuccess) {
        // Se o login foi bem-sucedido
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso!')),
        );
        // O próximo passo seria navegar para a tela principal
        // Navigator.of(context).pushReplacement(...);
      } else {
        // Se o login falhou
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credenciais inválidas. Tente novamente.'),
          ),
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
            child: Center(
              child: Text(
                "Fitmeta",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Digite seu email',
                border: OutlineInputBorder(),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("Senha", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(
                hintText: 'Digite seu email',
                border: OutlineInputBorder(),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed:
                    _isLoading
                        ? null
                        : _submit, // Desabilita o botão enquanto está carregando
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Entrar'),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () => {},
                child: Text("Esqueceu sua senha?"),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () => {},
                child: Text("Registre-se"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
