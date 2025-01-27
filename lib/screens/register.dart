import 'package:flutter/material.dart';
import 'package:teste/services/auth_services.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                        controller: _nomeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _mailController,
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
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'senha',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _confirmaSenhaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'senha',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          child: Text('Entrar'),
                          onPressed: () {
                            if (_senhaController.text ==
                                _confirmaSenhaController.text) {
                              authServices
                                  .cadastrarUsuario(
                                      email: _mailController.text,
                                      senha: _senhaController.text,
                                      nome: _nomeController.text)
                                  .then((String? erro) {
                                if (erro != null) {
                                  final snackBar = SnackBar(
                                    content: Text(erro),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            } else {
                              final snackBar = SnackBar(
                                content: Text('Senhas não conferem'),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
