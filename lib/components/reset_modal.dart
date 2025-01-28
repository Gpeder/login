import 'package:flutter/material.dart';
import 'package:teste/services/auth_services.dart';

class ResetModal extends StatefulWidget {
  const ResetModal({super.key});

  @override
  State<ResetModal> createState() => _ResetModalState();
}

class _ResetModalState extends State<ResetModal> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Redefinir Senha'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Endereço de e-mail',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Insira um endereço de e-mail.';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        TextButton(
          child: Text('Recuperar Senha'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              authServices
                  .redefinicaoSenha(email: _emailController.text)
                  .then((erro) {
                Navigator.of(context).pop();

                if (erro != null) {
                  final snackBar = SnackBar(content: 
                  Text('erro'),
                  backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }else{
                  final snackBar = SnackBar(content: 
                  Text('Um email de redefinição de senha foi enviado para : ${_emailController.text}'),
                  backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
            }
          },
        )
      ],
    );
  }
}
