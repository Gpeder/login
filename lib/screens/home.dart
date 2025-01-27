import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({super.key, required this.user, });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Hour> listHours = [];
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
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add),),

      body: (listHours.isEmpty)? const Center(
        child: Text('Nada por aqui\n Vamos registrar um dia de trabalho?', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
      ) : ListView(
        padding: const EdgeInsets.only(left: 4, right: 4),
        children: List.generate(listHours.length, (index) {Hour model = listHours[index]});
      )
    );
  }
}