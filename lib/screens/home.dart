import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teste/components/botao.dart';
import 'package:teste/components/custom_textfield.dart';
import 'package:teste/components/menu.dart';
import 'package:teste/helpers/hours_helpers.dart';
import 'package:teste/models/hour.dart';

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
              mask: minutosMaskFormatter,
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

                  }
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void remove(Hour model) {}
}
