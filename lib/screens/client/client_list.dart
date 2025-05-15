import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/client_data.dart';
import '../../utils/size_config.dart';
import 'client_details.dart';

class Client_List extends StatefulWidget {
  final Function() clearFormFields;

  const Client_List({super.key, required this.clearFormFields});

  @override
  _Client_ListState createState() => _Client_ListState();
}

class _Client_ListState extends State<Client_List> {
  List<FormData> formDataList = [];

  @override
  void initState() {
    super.initState();
    loadFormDataList();
  }

  Future<void> loadFormDataList() async {
    final prefs = await SharedPreferences.getInstance();
    final formDataListJson = prefs.getStringList('formDataList') ?? [];
    setState(() {
      formDataList =
          formDataListJson
              .map((json) => FormData.fromJson(jsonDecode(json)))
              .toList();
    });
  }

  Future<void> clearFormDataList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('formDataList');
    setState(() {
      formDataList = [];
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
              widget.clearFormFields();
            });
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.white,
        ),
        title: const Text(
          'Clients List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: clearFormDataList,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top:
              isWeb
                  ? SizeConfig.heightMultiplier * 2
                  : SizeConfig.heightMultiplier * 0.5,
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
          itemCount: formDataList.length,
          itemBuilder: (context, index) {
            final formData = formDataList[index];
            return Card(
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
                  top: SizeConfig.heightMultiplier * 1,
                  bottom: SizeConfig.heightMultiplier * 1,
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
                      height:
                          isWeb
                              ? SizeConfig.heightMultiplier * 8
                              : SizeConfig.heightMultiplier * 7,
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
                      height:
                          isWeb
                              ? SizeConfig.heightMultiplier * 9
                              : SizeConfig.heightMultiplier * 12,
                      width:
                          isWeb
                              ? SizeConfig.widthMultiplier * 15
                              : SizeConfig.widthMultiplier * 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formData.clientName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize:
                                  isWeb
                                      ? SizeConfig.heightMultiplier * 3
                                      : SizeConfig.heightMultiplier * 2,
                              color: HexColor("#1E4684"),
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 0.3),
                          Text(
                            formData.contactNumber,
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
                          size:
                              isWeb
                                  ? SizeConfig.heightMultiplier * 4
                                  : SizeConfig.heightMultiplier * 3,
                          color: HexColor("#1E4684"),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Client_Details(formData: formData),
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
