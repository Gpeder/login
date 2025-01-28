import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teste/components/botao.dart';
import 'package:teste/components/custom_textfield.dart';
import 'package:teste/components/menu.dart';
import 'package:teste/helpers/hours_helpers.dart';
import 'package:teste/models/hour.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({
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
    setupFMC();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(user: widget.user),
      appBar: AppBar(
        title: Text('Horas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormModal();
        },
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(left: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.white,
                      ),
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
                          onLongPress: () {
                            showFormModal(model: model);
                          },
                          onTap: () => {},
                          leading: Icon(
                            Icons.list_alt_rounded,
                            size: 50,
                          ),
                          title: Text(
                              'Data: ${model.date} hora: ${HoursHelpers.minutosToHours(model.minutos)}'),
                          subtitle: Text(model.descricao!),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
    );
  }

  void showFormModal({Hour? model}) {
    String title = "Adicionar";
    String confirmaButton = "Salvar";
    String skipButton = "Cancelar";

    TextEditingController dateController = TextEditingController();
    final dataMaskFormatter = MaskTextInputFormatter(mask: '##/##/####');

    TextEditingController minutosController = TextEditingController();
    final minutosMaskFormatter = MaskTextInputFormatter(mask: '##:##');

    TextEditingController descricaoController = TextEditingController();

    if (model != null) {
      title = "Editando";
      dateController.text = model.date;
      minutosController.text = HoursHelpers.minutosToHours(model.minutos);
      if (model.descricao != null) descricaoController.text = model.descricao!;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(32),
        child: ListView(
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 20),
            CustomTextFormField(
              obscureText: false,
              controller: dateController,
              keyboardType: TextInputType.datetime,
              hintText: '01/02/2028',
              labelText: 'Data',
              mask: dataMaskFormatter,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              obscureText: false,
              controller: minutosController,
              keyboardType: TextInputType.number,
              hintText: '00:00',
              labelText: 'Horas trabalhadas',
              mask: minutosMaskFormatter,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              obscureText: false,
              controller: descricaoController,
              keyboardType: TextInputType.text,
              hintText: 'Lembrete do que você fez!',
              labelText: 'Descrição',
              mask: null,
            
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                  child: Text(skipButton),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                Botao(
                  text: confirmaButton,
                  width: 80,
                  onPressed: () {
                    Hour hour = Hour(
                      id: const Uuid().v1(),
                      date: dateController.text,
                      minutos: HoursHelpers.hoursToMinutos(minutosController.text),
                      descricao: descricaoController.text,
                      );
                      if (descricaoController.text != '') {
                        hour.descricao = descricaoController.text;
                      }
                      if (model != null) {
                        hour.id = model.id;
                      }
                      firestore.collection(widget.user.uid).add(hour.toMap());
                      refresh();
                      Navigator.pop(context);
                  }
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void remove(Hour model) => firestore.collection(widget.user.uid).doc(model.id).delete();  
  
  Future<void> refresh() async {
    List<Hour> temp = [];


    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore.collection(widget.user.uid).get();
    for (var doc in snapshot.docs) {
      temp.add(Hour.fromMap(doc.data()));
    }
    setState(() {
      listHours = temp;
    });
  }
}

void setupFMC() async {
  try {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $fcmToken');

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('USER DECLINED PERMISSION');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('message data: ${message.data}');

      if (message.notification != null) {
        print('message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  } catch (e) {
    print('Erro ao configurar FCM: $e');
  }
}
