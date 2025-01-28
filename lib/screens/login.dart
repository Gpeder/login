import 'package:flutter/material.dart';
import 'package:teste/components/botao.dart';
import 'package:teste/screens/register.dart';
import 'package:teste/services/auth_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();

  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff1976D2),
                Color(0xff03A9F4),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    FlutterLogo(size: 100,),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'senha',
                      ),
                    ),
                    SizedBox(height: 20,),
                    Botao(
                      text: 'Entrar',
                      width: double.infinity,
                      onPressed: () async {
                        String? erro = await authServices.entraUsuario(
                          email: _emailController.text,
                          senha: _senhaController.text,
                        );
                        if (erro != null) {
                          final snackBar = SnackBar(
                            content: Text(erro),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                    SizedBox(height: 20,),
                    TextButton.icon(
                      label: Text('Entrar com Google'),
                      icon: Icon(Icons.login),
                      onPressed: () {},
                    ),
                    SizedBox(height: 20,),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      label: Text('Criar conta'),
                      icon: Icon(Icons.app_registration),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
