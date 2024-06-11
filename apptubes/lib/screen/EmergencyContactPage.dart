import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/custom_text_field.dart';

class EmergencyContactPage extends StatefulWidget {
  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _showAddContactDialog() {
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
                  addEmergencyContact(_nameController.text, _phoneNumberController.text);
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
        backgroundColor: Color.fromRGBO(255, 192, 65, 1),
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
            Expanded(
              child: Column(
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
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('emergency contact')
                          .where('email', isEqualTo: user?.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No contacts available'));
                        }

                        return ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(data['name'][0].toUpperCase()),
                              ),
                              title: Text(data['name']),
                              subtitle: Text(data['phoneNumber']),
                              trailing: IconButton(
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber(data['phoneNumber']);
                                },
                                icon: ImageIcon(
                                  AssetImage("lib/icons/call.png"),
                                  size: 23.0,
                                  color: Colors.blue,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> addEmergencyContact(String name, String phoneNumber) async {
    String email = user?.email ?? '';

    await FirebaseFirestore.instance.collection('emergency contact').add({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email
    });
  }

}
