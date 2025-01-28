class Hour {
  String id;
  String date;
  int minutos;
  String? descricao;

  Hour(
      {required this.id,
      required this.date,
      required this.minutos, required String descricao,});

    Hour.fromMap(Map<String, dynamic> map) :
      id = map['id'],
      date = map['date'],
      minutos = map['minutos'],
      descricao = map['descricao'];
    
      Map<String, dynamic> toMap() {
        return{
          'id': id,
          'date': date,
          'minutos': minutos,
          'descricao': descricao
        };
}
}
