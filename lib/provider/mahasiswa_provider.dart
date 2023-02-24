import 'dart:convert';

import 'package:crud_provider/model/mahasiswa_model.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MahasiswaProvider extends ChangeNotifier {
  List<MahasiswaModel> _dataMhs = [];
  List<MahasiswaModel> get dataMhs => _dataMhs;

  Future<void> getDataMhs() async {
    final response = await http.get(
        Uri.parse("https://x8ki-letl-twmt.n7.xano.io/api:O3_Qi3tw/student"));
    final List<dynamic> data = json.decode(response.body);
    _dataMhs = data.map((json) => MahasiswaModel.fromJson(json)).toList();
    notifyListeners();
  }

  Future<void> addData(MahasiswaModel data) async {
    final response = await http.post(
      Uri.parse("https://x8ki-letl-twmt.n7.xano.io/api:O3_Qi3tw/student"),
      body: json.encode({'name': data.name, 'nim': data.nim}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _dataMhs.add(data);
      notifyListeners();
    } else {
      throw Exception('Failed add data');
    }
  }

  Future<void> deletData(int? id) async {
    final response = await http.delete(
        Uri.parse(
            "https://x8ki-letl-twmt.n7.xano.io/api:O3_Qi3tw/student/${id}"),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      _dataMhs.removeWhere((element) => element.id == id);
      notifyListeners();
    } else {
      throw Exception('Failed to delete data');
    }
  }
}
