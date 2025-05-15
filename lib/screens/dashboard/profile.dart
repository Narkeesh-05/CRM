import 'package:demo/screens/lead/new_lead.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../client/new_client.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 35.0,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage('images/profile.jpeg'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.edit, color: HexColor("#1E4684")),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Narkeesh Banu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#1E4684"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: ListTile(
              title: Text(
                'Lead',
                style: TextStyle(fontSize: 16, color: HexColor("#1E4684")),
              ),
              trailing: Icon(Icons.add, color: HexColor("#385b89")),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LeadForm()),
              );
            },
          ),
          InkWell(
            child: ListTile(
              title: Text(
                'Client',
                style: TextStyle(fontSize: 16, color: HexColor("#1E4684")),
              ),
              trailing: Icon(Icons.add, color: HexColor("#385b89")),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyForm()),
              );
            },
          ),
        ],
      ),
    );
  }
}
