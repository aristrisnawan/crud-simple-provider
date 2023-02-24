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
                            Icon(Icons.update),
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
}
