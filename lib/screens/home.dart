import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste/components/menu.dart';
import 'package:teste/models/hour.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({
    super.key,
    required this.user,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Hour> listHours = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(user: widget.user),
        appBar: AppBar(
          title: Text('Horas'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: (listHours.isEmpty)
            ? Center(
                child: Text(
                  'Nada por aqui\n Vamos registrar um dia de trabalho?',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView(
                padding: const EdgeInsets.only(left: 4, right: 4),
                children: List.generate(listHours.length, (index) {
                  Hour model = listHours[index];
                  return Dismissible(
                    key: ValueKey<Hour>(model),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(left: 10),
                      color: Colors.redAccent,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      remove(model);
                    },
                    child: Card(
                      elevation: 2,
                      child: Column(
                        children: [
                          ListTile(
                            onLongPress: () {},
                            onTap: () => {},
                            leading: Icon(
                              Icons.list_alt_rounded,
                              size: 50,
                            ),
                            title: Text(
                                'Data: ${model.date} hora: ${model.minutos}'),
                            subtitle: Text(model.descricao!),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ));
  }
void remove(Hour model) {}

}

