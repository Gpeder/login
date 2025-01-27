import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final User user;
  const Menu({super.key, required this.user});

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
          Divider(color: Colors.black),
        ],
      ),
    );
  }
}
