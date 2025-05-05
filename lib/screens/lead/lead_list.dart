import 'dart:convert';
import 'package:demo/model/lead_data.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/size_config.dart';
import 'lead_details.dart';

class LeadList extends StatefulWidget {
  final Function() clearLeadFields;

  LeadList({required this.clearLeadFields});

  @override
  _LeadListState createState() => _LeadListState();
}

class _LeadListState extends State<LeadList> {
  List<LeadData> leadDataList = [];

  @override
  void initState() {
    super.initState();
    loadLeadDataList();
  }

  // Load saved form data from SharedPreferences
  Future<void> loadLeadDataList() async {
    final sp = await SharedPreferences.getInstance();
    final leadDataListJson = sp.getStringList('leadDataList') ?? [];
    setState(() {
      leadDataList =
          leadDataListJson
              .map((json) => LeadData.fromJson(jsonDecode(json)))
              .toList();
    });
  }

  // Clear saved form data
  Future<void> clearLeadDataList() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('leadDataList');
    setState(() {
      leadDataList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = SizeConfig.screenWidth > 600;
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor("#1E4684"),
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            setState(() {
              widget.clearLeadFields();
            });
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.white,
        ),
        title: const Text('Leads List', style: TextStyle(color: Colors.white)),
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: clearLeadDataList,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: isWeb?SizeConfig.heightMultiplier * 2:SizeConfig.heightMultiplier * 0.5,
          left:
              isWeb
                  ? SizeConfig.widthMultiplier * 34
                  : SizeConfig.widthMultiplier * 2,
          right:
              isWeb
                  ? SizeConfig.widthMultiplier * 34
                  : SizeConfig.widthMultiplier * 2,
          bottom: SizeConfig.heightMultiplier * 4,
        ),
        child: ListView.builder(
          itemCount: leadDataList.length,
          itemBuilder: (context, index) {
            final leadData = leadDataList[index];
            return Card(
              // margin: EdgeInsets.all(SizeConfig.heightMultiplier * 1),
              child: Container(
                height:
                    isWeb
                        ? SizeConfig.heightMultiplier * 10
                        : SizeConfig.heightMultiplier * 8,
                width:
                    isWeb
                        ? SizeConfig.widthMultiplier * 45
                        : SizeConfig.widthMultiplier * 90,
                padding: EdgeInsets.only(
                  // left: SizeConfig.widthMultiplier * 1,
                  top: SizeConfig.heightMultiplier * 1,
                  bottom: SizeConfig.heightMultiplier * 1,
                  // right: SizeConfig.widthMultiplier * 1,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                  border: Border.all(width: 0.5, color: HexColor("#1E4684")),
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width:
                          isWeb
                              ? SizeConfig.widthMultiplier * 5
                              : SizeConfig.widthMultiplier * 15,
                      height: isWeb?SizeConfig.heightMultiplier * 8:SizeConfig.heightMultiplier*7,
                      child: CircleAvatar(
                        backgroundColor: HexColor("#1E4684"),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: SizeConfig.widthMultiplier * 1),
                    SizedBox(
                      height: isWeb?SizeConfig.heightMultiplier * 9:SizeConfig.heightMultiplier*12,
                      width: isWeb?SizeConfig.widthMultiplier * 15:SizeConfig.widthMultiplier*60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${leadData.leadName}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize:
                                  isWeb
                                      ? SizeConfig.heightMultiplier * 3
                                      : SizeConfig.heightMultiplier * 2,
                              color: HexColor("#1E4684"),
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier*0.3,),
                          Text(
                            leadData.contactNumber,
                            style: TextStyle(
                              fontSize:
                                  isWeb
                                      ? SizeConfig.heightMultiplier * 2
                                      : SizeConfig.heightMultiplier * 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width:
                          isWeb
                              ? SizeConfig.widthMultiplier * 5
                              : SizeConfig.widthMultiplier * 5,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 7,
                      width: SizeConfig.widthMultiplier * 5,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: isWeb?SizeConfig.heightMultiplier*4:SizeConfig.heightMultiplier*3,
                          color: HexColor("#1E4684"),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => Lead_Details(leadData: leadData),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
