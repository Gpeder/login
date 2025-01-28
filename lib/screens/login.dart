import 'package:flutter/material.dart';
import 'package:teste/components/botao.dart';
import 'package:teste/screens/register.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

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
                    FlutterLogo(
                      size: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _senhaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'senha',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Botao(
                      text: 'Entrar',
                      onPressed: () {},
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      label: Text('Entrar com Google'),
                      icon: Icon(Icons.login),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
