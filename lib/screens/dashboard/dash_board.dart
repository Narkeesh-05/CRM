import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/dashboard/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/size_config.dart';
import 'chart.dart';
import '../../model/lead_data.dart';

class Dash_Board extends StatefulWidget {
  const Dash_Board({super.key});

  @override
  State<Dash_Board> createState() => _Dash_BoardState();
}

class _Dash_BoardState extends State<Dash_Board> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int noOfLeads = 0;
  int closedLeads = 0;
  int processLeads = 0;
  int initialLevelLeads = 0;
  int proposalSentLeads = 0;

  @override
  void initState() {
    super.initState();
    loadLeadData();
  }

  Future<void> loadLeadData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Leads').get();
      final leadDocs = snapshot.docs;
      setState(() {
        noOfLeads = leadDocs.length;
        closedLeads =
            leadDocs.where((doc) => doc['leadStage'] == 'Closed').length;
        processLeads =
            leadDocs.where((doc) => doc['leadStage'] == 'Process').length;
        initialLevelLeads =
            leadDocs.where((doc) => doc['leadStage'] == 'Initial').length;
        proposalSentLeads =
            leadDocs.where((doc) => doc['leadStage'] == 'Yes').length;
      });
    } catch (e) {
      print('Error loading lead data from Firestore: $e');
    }
  }
  // // Fetch lead data and calculate counts
  // Future<void> loadLeadData() async {
  //   final sp = await SharedPreferences.getInstance();
  //   final leadDataListJson = sp.getStringList('leadDataList') ?? [];

  //   // Parse JSON to LeadData objects
  //   List<LeadData> leadDataList =
  //   leadDataListJson.map((json) => LeadData.fromJson(jsonDecode(json))).toList();

  //   // Calculate counts for each status
  //   setState(() {
  //     noOfLeads = leadDataList.length;
  //     closedLeads = leadDataList.where((lead) => lead.leadStage == 'Closed').length;
  //     processLeads = leadDataList.where((lead) => lead.leadStage == 'Process').length;
  //     initialLevelLeads = leadDataList.where((lead) => lead.leadStage == 'Initial').length;
  //     proposalSentLeads = leadDataList.where((lead) => lead.proposalStatus == 'Yes').length;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyProfile(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.3,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: const CircleAvatar(
              radius: 35.0,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('images/logo.jpeg'),
            ),
          ),
        ),
        title: Text(
          'COMMON CRM',
          style: TextStyle(
            color: HexColor("#1E4684"),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: HexColor("#1E4684")),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWeb = constraints.maxWidth > 600;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 4,
                left: SizeConfig.widthMultiplier * 4,
                right: SizeConfig.widthMultiplier * 4,
                bottom: SizeConfig.heightMultiplier * 4,
              ),
              child: Column(
                children: [
                  GridView.count(
                    crossAxisCount: isWeb ? 3 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.5,
                    mainAxisSpacing:
                        isWeb
                            ? SizeConfig.heightMultiplier * 10
                            : SizeConfig.heightMultiplier,
                    crossAxisSpacing:
                        isWeb
                            ? SizeConfig.widthMultiplier * 20
                            : SizeConfig.widthMultiplier * 1,
                    children: [
                      buildCard(
                        "No Of Leads",
                        noOfLeads.toString(),
                        Icons.bolt,
                        HexColor("#1E4684"),
                        isWeb,
                      ),
                      buildCard(
                        "Closed Leads",
                        closedLeads.toString(),
                        Icons.fact_check,
                        Colors.red,
                        isWeb,
                      ),
                      buildCard(
                        "Process Leads",
                        processLeads.toString(),
                        Icons.trending_up,
                        Colors.yellow,
                        isWeb,
                      ),
                      buildCard(
                        "Initial Level",
                        initialLevelLeads.toString(),
                        Icons.layers,
                        Colors.blue,
                        isWeb,
                      ),
                      buildCard(
                        "Proposal Sent",
                        proposalSentLeads.toString(),
                        Icons.forward_to_inbox,
                        Colors.green,
                        isWeb,
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        isWeb
                            ? SizeConfig.heightMultiplier * 20
                            : SizeConfig.heightMultiplier * 0.1,
                  ),
                  Lead_Chart(
                    noOfLeads: noOfLeads,
                    closedLeads: closedLeads,
                    processLeads: processLeads,
                    initialLevelLeads: initialLevelLeads,
                    proposalSentLeads: proposalSentLeads,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCard(
    String title,
    String value,
    IconData icon,
    Color borderColor,
    bool isWeb,
  ) {
    return Card(
      child: Container(
        height:
            isWeb
                ? SizeConfig.heightMultiplier * 20
                : SizeConfig.heightMultiplier * 80,
        width:
            isWeb
                ? SizeConfig.widthMultiplier * 6
                : SizeConfig.widthMultiplier * 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
          border: Border.all(width: 0.5, color: borderColor),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(icon, color: HexColor("#1E4684"), size: 20),
            const SizedBox(width: 11),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: HexColor("#1E4684"),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    color: borderColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
