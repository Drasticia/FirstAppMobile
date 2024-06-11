import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../components/custom_text_field.dart';

class EmergencyContactPage extends StatefulWidget {
  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  final List<Map<String, String>> _contacts = [];

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
        return AlertDialog(
          title: Text('Tambah Kontak Baru'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
          actions: [
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
                      fontSize: 17,
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('PL'),
                    ),
                    title: Text('Polisi'),
                    trailing: IconButton(
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber('+6281283115727');
                      },
                      icon: ImageIcon(
                        AssetImage("lib/icons/call.png"),
                        size: 23.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('PK'),
                    ),
                    title: Text('Pemadam Kebakaran'),
                    trailing: IconButton(
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber('+6281283115727');
                      },
                      icon: ImageIcon(
                        AssetImage("lib/icons/call.png"),
                        size: 23.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
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
                    fontSize: 17,
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
                ..._contacts.map((contact) {
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
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
