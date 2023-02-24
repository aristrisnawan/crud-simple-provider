import 'package:crud_provider/list.dart';
import 'package:crud_provider/main.dart';
import 'package:crud_provider/model/mahasiswa_model.dart';
import 'package:crud_provider/provider/mahasiswa_provider.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  //Vlidatin form null
  final _formKey = GlobalKey<FormState>();

  submitData() async {
    final provider = Provider.of<MahasiswaProvider>(context, listen: false);
    final data =
        MahasiswaModel(name: _nameController.text, nim: _nimController.text);

    // if (_formKey.currentState!.validate()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Processing Data')),
    //   );
    // } else {
    await provider.addData(data);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => ChangeNotifierProvider(
                create: (context) => MahasiswaProvider(), child: MyApp()))));
    DInfo.dialogSuccess(context, "Add data success");
    DInfo.closeDialog(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ini App bar"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _nimController,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nim',
                      hintText: 'Enter Your Nim',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter youre nim';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _nameController.clear();
                          _nimController.clear();
                        },
                        child: Text("Reset"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            submitData();
                          },
                          child: Text("Submit")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
