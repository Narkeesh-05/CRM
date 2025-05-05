import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/model/lead_data.dart';
import 'package:demo/utils/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'lead_list.dart';

class LeadForm extends StatefulWidget {
  @override
  _LeadFormState createState() => _LeadFormState();
}

class _LeadFormState extends State<LeadForm> {
  final GlobalKey<FormState> _leadKey = GlobalKey<FormState>();
  List _products = [];
  List _initialProducts = [];

  @override
  void initState() {
    super.initState();
    _products = [];
  }

  var orientation, size, height, width;
  final _employeeNameController = TextEditingController();
  final _leadNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _servicesController = TextEditingController();
  final _quantityController = TextEditingController();
  final _enquiryDateController = TextEditingController();
  final _followUpDateController = TextEditingController();
  String? _proposalStatus;
  String? _leadStage;
  String? _leadReceivedCategory;

  DateTime? _selectedDate;
  bool isEmailValid = true;

  void validateEmail(String value) {
    setState(() {
      isEmailValid = value.isNotEmpty && value.contains('@');
    });
  }

  @override
  void dispose() {
    _employeeNameController.dispose();
    _leadNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    _servicesController.dispose();
    _quantityController.dispose();
    _enquiryDateController.dispose();
    _followUpDateController.dispose();
    _products = [];
    _initialProducts = [];
    super.dispose();
  }

  void clearLeadFields() {
    _employeeNameController.clear();
    _leadNameController.clear();
    _contactNumberController.clear();
    _emailController.clear();
    _addressController.clear();
    _pincodeController.clear();
    _servicesController.clear();
    _quantityController.clear();
    _enquiryDateController.clear();
    _followUpDateController.clear();
    _products = [];
    _initialProducts = [];
    _proposalStatus = null;
    _leadStage = null;
    _leadReceivedCategory = null;
    setState(() {});
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: HexColor(
                "#b0d8e9",
              ), //header and selced day background color
              onPrimary: Colors.white, // titles and
              onSurface: HexColor("#1E4684"), // Month days , years
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: HexColor("#1E4684")),
            ),
          ),
          child: child!,
        );
        //  here you can return  a child
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> saveLeadData(LeadData leadData) async {
    try {
      await FirebaseFirestore.instance
          .collection('Leads')
          .add(leadData.toJson());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Lead saved successfully')));

      clearLeadFields();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving lead: $e')));
    }
  }
  // Save form data to SharedPreferences
  // Future<void> saveLeadData(LeadData leadData) async {
  //   final sp = await SharedPreferences.getInstance();
  //   final leadDataListJson =
  //       sp.getStringList('leadDataList') ?? []; // Get existing data
  //   leadDataListJson.add(jsonEncode(leadData.toJson())); // Add new data
  //   sp.setStringList('leadDataList', leadDataListJson); // Save updated list
  // }

  void _submitAndSaveLead() async {
    if (_leadKey.currentState!.validate()) {
      final leadData = LeadData(
        employeeName: _employeeNameController.text,
        leadName: _leadNameController.text,
        contactNumber: _contactNumberController.text,
        email: _emailController.text,
        address: _addressController.text,
        pincode: _pincodeController.text,
        services: _servicesController.text,
        quantity: _quantityController.text,
        enquiryDate: _enquiryDateController.text,
        followUpDate: _followUpDateController.text,
        proposalStatus: _proposalStatus ?? '',
        leadStage: _leadStage ?? '',
        leadReceivedCategory: _leadReceivedCategory ?? '',
      );

      // saveLeadData(leadData).then((_) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Lead details are saved successfully!')),
      //   );

      //   clearLeadFields();
      // });

      try {
        await FirebaseFirestore.instance
            .collection('Leads')
            .add(leadData.toJson());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lead saved successfully!')),
        );
        clearLeadFields();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving lead: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = SizeConfig.screenWidth > 600;
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#1E4684"),
        elevation: 3,
        leading: const BackButton(color: Colors.white),
        title: const Text('Lead Form', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => LeadList(clearLeadFields: clearLeadFields),
                ),
              );
            },
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Stack(
          children: [
            Center(
              child: Container(
                width:
                    isWeb
                        ? SizeConfig.widthMultiplier * 70
                        : SizeConfig.widthMultiplier * double.infinity,
                color: isWeb ? Colors.grey.shade200 : Colors.transparent,
              ),
            ),
            Padding(
              // padding: const EdgeInsets.all(16.0),
              padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 2,
                left:
                    isWeb
                        ? SizeConfig.widthMultiplier * 30
                        : SizeConfig.widthMultiplier * 3,
                right:
                    isWeb
                        ? SizeConfig.widthMultiplier * 30
                        : SizeConfig.widthMultiplier * 3,
                bottom: SizeConfig.heightMultiplier * 4,
              ),
              child: Form(
                key: _leadKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Employee Name',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      TextFormField(
                        controller: _employeeNameController,
                        cursorColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'Enter employee name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the marketer/employee name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      Text(
                        'Lead Name',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _leadNameController,
                        cursorColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'Enter lead name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the client name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),

                      Text(
                        'Contact Number',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      TextFormField(
                        controller: _contactNumberController,
                        cursorColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'Enter contact number',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the contact number';
                          } else if (value.length != 10) {
                            return 'Contact number must be exactly 10 digits';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      TextFormField(
                        controller: _emailController,
                        cursorColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'Enter email id',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          errorText:
                              isEmailValid ? null : 'Enter a valid email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: validateEmail,
                      ),
                      const SizedBox(height: 20),

                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      TextFormField(
                        controller: _addressController,
                        cursorColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'Enter the address',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      Text(
                        'Pin code',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      TextFormField(
                        controller: _pincodeController,
                        cursorColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'Enter the pin code',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the pin code';
                          } else if (value.length != 6) {
                            return 'Pin code must be exactly 6 digits';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),

                      Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: const InputDecorationTheme(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                            // border: Border(
                            //   left: BorderSide(
                            //     color: HexColor("#1E4684"),
                            //     width: 1.5,
                            //   ),
                            //   right: BorderSide(
                            //     color: HexColor("#1E4684"),
                            //     width: 1.5,
                            //   ),
                            //   top: BorderSide(
                            //     color: HexColor("#1E4684"),
                            //     width: 1.5,
                            //   ),
                            // ),
                            borderRadius:
                                isWeb
                                    ? BorderRadius.circular(5)
                                    : BorderRadius.circular(15),
                          ),
                          child: MultiSelectFormField(
                            autovalidate: AutovalidateMode.disabled,
                            chipBackGroundColor: Colors.transparent,
                            chipLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HexColor("#1E4684"),
                            ),
                            fillColor: Colors.transparent,
                            dialogTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),

                            checkBoxActiveColor: HexColor("#1E4684"),
                            checkBoxCheckColor: Colors.white,
                            dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            title: Text(
                              "Product Category",
                              style: TextStyle(color: HexColor("#1E4684")),
                            ),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return 'Please select one or more options';
                              }
                              return null;
                            },
                            dataSource: const [
                              {"display": "Category A", "value": "Category A"},
                              {"display": "Category B", "value": "Category B"},
                              {"display": "Category C", "value": "Category C"},
                              {"display": "Category D", "value": "Category D"},
                            ],
                            textField: 'display',
                            valueField: 'value',
                            okButtonLabel: 'OK',
                            cancelButtonLabel: 'CANCEL',
                            initialValue: _products,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                _products = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      Text(
                        'Services',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      TextFormField(
                        controller: _servicesController,
                        cursorColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'Enter the service name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the services';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      TextFormField(
                        controller: _quantityController,
                        cursorColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'Enter the quantity',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the no of quantity';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),

                      Text(
                        'Enquiry Date',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      TextFormField(
                        controller: _enquiryDateController,
                        cursorColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'Enter enquiry date',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_month_sharp,
                              color: HexColor("#1E4684"),
                            ),
                            onPressed: () {
                              _selectDate(context, _enquiryDateController);
                            },
                          ),
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select the enquiry date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      Text(
                        'Follow-Up Date',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      TextFormField(
                        controller: _followUpDateController,
                        decoration: InputDecoration(
                          hintText: 'Enter follow-up date',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_month_sharp,
                              color: HexColor("#1E4684"),
                            ),
                            onPressed: () {
                              _selectDate(context, _followUpDateController);
                            },
                          ),
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select the follow-up date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      Text(
                        'Proposal Status',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      DropdownButtonFormField<String>(
                        iconEnabledColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'select proposal status',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        items:
                            ['Yes', 'No'].map((status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                        onChanged: (value) async {
                          if (value == 'Yes') {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: HexColor("#b0d8e9"),
                                      onPrimary: Colors.white, // titles and
                                      onSurface: HexColor(
                                        "#1E4684",
                                      ), // Month days , years
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: HexColor("#1E4684"),
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _proposalStatus = 'Yes';
                                _selectedDate = pickedDate;
                              });
                            }
                          } else {
                            setState(() {
                              _proposalStatus = 'No';
                              _selectedDate = null;
                            });
                          }
                        },
                        value: _proposalStatus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select the proposal stage';
                          }
                          return null;
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return ['Yes', 'No'].map((status) {
                            if (status == 'Yes' && _selectedDate != null) {
                              return Text(
                                _selectedDate!.toLocal().toString().split(
                                  ' ',
                                )[0],
                              );
                            } else {
                              return Text(status);
                            }
                          }).toList();
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      Text(
                        'lead Stage',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      DropdownButtonFormField<String>(
                        value: _leadStage,
                        items:
                            ['Initial', 'Process', 'Final Stage', 'Closed'].map(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                        onChanged: (value) {
                          setState(() {
                            _leadStage = value;
                          });
                        },
                        iconEnabledColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'select the lead stage ',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select the lead stage';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),

                      Text(
                        'Lead Received Category',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: HexColor("#1E4684"),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      DropdownButtonFormField<String>(
                        value: _leadReceivedCategory,
                        items:
                            ['Online', 'Offline', 'Referral'].map((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _leadReceivedCategory = value;
                          });
                        },
                        iconEnabledColor: HexColor("#1E4684"),
                        decoration: InputDecoration(
                          hintText: 'select the lead received category ',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                isWeb
                                    ? SizeConfig.heightMultiplier * 2.5
                                    : SizeConfig.heightMultiplier * 1.7,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            16.0,
                            20.0,
                            16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                isWeb
                                    ? BorderRadius.all(Radius.circular(5.0))
                                    : BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                              color: HexColor("#1E4684"),
                              width: 1.5,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select the lead received category';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 50),
                      Center(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              backgroundColor: HexColor("#1E4684"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.5),
                              ),
                            ),
                            onPressed: () {
                              if (_leadKey.currentState!.validate()) {
                                _submitAndSaveLead();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => LeadList(
                                          clearLeadFields: clearLeadFields,
                                        ),
                                  ),
                                ).then((value) {
                                  setState(() {
                                    _products = _initialProducts;
                                  });
                                  _leadKey.currentState?.reset();
                                });
                              }
                            },
                            // onPressed: _submitAndSaveForm1,
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
