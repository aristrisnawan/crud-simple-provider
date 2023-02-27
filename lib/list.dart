import 'package:crud_provider/model/mahasiswa_model.dart';
import 'package:crud_provider/provider/mahasiswa_provider.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MahasiswaProvider>(context, listen: false).getDataMhs();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Mahasiswa"),
      ),
      body: Consumer<MahasiswaProvider>(
        builder: (context, value, child) {
          if (value.dataMhs.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: value.dataMhs.length,
                itemBuilder: ((context, index) {
                  final datas = value.dataMhs[index];
                  final nomor = index + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(nomor.toString()),
                            SizedBox(
                              width: 3,
                            ),
                            Text(datas.name),
                            SizedBox(
                              width: 3,
                            ),
                            Text("==>"),
                            SizedBox(
                              width: 3,
                            ),
                            Text(datas.nim)
                          ],
                        ),
                        //Action
                        Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  dialogPopup(context, datas.name, datas.nim,
                                      datas.id, value);
                                },
                                child: Icon(Icons.update)),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                                onTap: () async {
                                  await value.deletData(datas.id);
                                  DInfo.dialogSuccess(
                                      context, "Success delete data");
                                  DInfo.closeDialog(context);
                                },
                                child: Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  );
                }));
          }
        },
      ),
    );
  }

  Future<String?> dialogPopup(BuildContext context, String name, String nim,
      int? id, MahasiswaProvider value) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Edit Data'),
        content: Material(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: TextEditingController(text: "${name}"),
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: TextEditingController(text: "${nim}"),
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ],
              )),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              // final updateData =
              //     value.updateData(MahasiswaModel(name: name, nim: nim), id);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
