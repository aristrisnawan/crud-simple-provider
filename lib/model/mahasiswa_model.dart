class MahasiswaModel {
  int? id;
  String name;
  String nim;

  MahasiswaModel({this.id, required this.name, required this.nim});

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) =>
      MahasiswaModel(id: json["id"], name: json["name"], nim: json["nim"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "nim": nim};
}
