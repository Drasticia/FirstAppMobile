import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../components/custom_text_field.dart';

class EmergencyContactPage extends StatefulWidget {
  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  final List<Map<String, String>> _contacts = [];
  final List<Map<String, String>> _aparaturNegara = [
    {'name': 'Polisi', 'initial': 'PL', 'phoneNumber': '+6281283115727'},
    {'name': 'Pemadam Kebakaran', 'initial': 'PK', 'phoneNumber': '+6281283115727'},
  ];

  void _addContact(String name, String phoneNumber) {
    setState(() {
      _contacts.add({'name': name, 'phoneNumber': phoneNumber});
    });
  }

  void _showAddContactDialog() {
    final _nameController = TextEditingController();
    final _phoneNumberController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
            height: MediaQuery.of(context).size.height * 0.35, // 50% of screen height
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tambah Kontak Baru',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: 'Nama',
                        hintText: 'Masukkan nama',
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: 'Nomor Telepon',
                        hintText: 'Masukkan nomor telepon',
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor telepon tidak boleh kosong';
                          } else if (value.length < 8 || value.length > 15) {
                            return 'Nomor telepon harus antara 8-15 karakter';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addContact(_nameController.text, _phoneNumberController.text);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Tambah'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Contact',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aparatur Negara',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _aparaturNegara.length,
                    itemBuilder: (context, index) {
                      final contact = _aparaturNegara[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(contact['initial']!),
                        ),
                        title: Text(contact['name']!),
                        trailing: IconButton(
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(contact['phoneNumber']!);
                          },
                          icon: ImageIcon(
                            AssetImage("lib/icons/call.png"),
                            size: 23.0,
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                  Divider(), // Divider bawah list aparatur negara
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keluarga',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                ListTile(
                  leading: ImageIcon(
                    AssetImage("lib/icons/contact.png"),
                    size: 40.0,
                    color: Colors.black,
                  ),
                  title: Text('Tambah Kontak Baru'),
                  trailing: IconButton(
                    onPressed: _showAddContactDialog,
                    icon: ImageIcon(
                      AssetImage("lib/icons/addContact.png"),
                      size: 23.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Divider(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    final contact = _contacts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(contact['name']![0].toUpperCase()),
                      ),
                      title: Text(contact['name']!),
                      subtitle: Text(contact['phoneNumber']!),
                      trailing: IconButton(
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(contact['phoneNumber']!);
                        },
                        icon: ImageIcon(
                          AssetImage("lib/icons/call.png"),
                          size: 23.0,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
