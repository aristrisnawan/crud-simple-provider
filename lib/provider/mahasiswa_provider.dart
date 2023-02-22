import 'dart:convert';

import 'package:crud_provider/model/mahasiswa_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MahasiswaProvider extends ChangeNotifier {
  List<MahasiswaModel> _dataMhs = [];
  List<MahasiswaModel> get dataMhs => _dataMhs;

  Future<void> getDataMhs() async {
    final response = await http.get(Uri.parse("https://x8ki-letl-twmt.n7.xano.io/api:O3_Qi3tw/student"));
    final List<dynamic> data = json.decode(response.body);
    _dataMhs = data.map((json) => MahasiswaModel.fromJson(json)).toList();
    notifyListeners();
  }
}