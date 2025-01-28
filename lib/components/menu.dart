import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu extends StatelessWidget {
  final User user;
  const Menu({super.key, required this.user});

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      // Solicitar reautenticação antes de deletar a conta
      final credential = await _promptForCredentials(context);
      if (credential != null) {
        await user.reauthenticateWithCredential(credential);
        await user.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Conta excluída com sucesso!')),
        );
        // Navegar para a tela de login ou outra tela apropriada
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir conta: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro desconhecido: $e')),
      );
    }
  }

  Future<AuthCredential?> _promptForCredentials(BuildContext context) async {
    final password = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: TextField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Senha'),
          onChanged: (value) => Navigator.of(context).pop(value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Confirmar'),
          ),
        ],
      ),
    );

    if (password != null && password.isNotEmpty) {
      return EmailAuthProvider.credential(email: user.email!, password: password);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user.displayName != null ? user.displayName! : '',
            ),
            accountEmail: Text(user.email!),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: Icon(
                Icons.manage_accounts_rounded,
                size: 50,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () => FirebaseAuth.instance.signOut(),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.trash),
            title: Text('Excluir Conta'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirmar Exclusão'),
                  content: Text('Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Excluir'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await _deleteAccount(context);
              }
            },
          ),
        ],
      ),
    );
  }
}