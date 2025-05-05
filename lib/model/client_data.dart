class FormData {
  String employeeName;
  String clientName;
  String contactNumber;
  String email;
  String address;
  String pincode;
  String services;
  String quantity;
  String enquiryDate;
  String followUpDate;
  String proposalStatus;
  String dealStage;
  String leadReceivedCategory;


  FormData({
    required this.employeeName,
    required this.clientName,
    required this.contactNumber,
    required this.email,
    required this.address,
    required this.pincode,
    required this.services,
    required this.quantity,
    required this.enquiryDate,
    required this.followUpDate,
    required this.proposalStatus,
    required this.dealStage,
    required this.leadReceivedCategory,

  });

  Map<String, dynamic> toJson() {
    return {
      'employeeName': employeeName,
      'clientName': clientName,
      'contactNumber': contactNumber,
      'email': email,
      'address': address,
      'pincode': pincode,
      'services': services,
      'quantity': quantity,
      'enquiryDate': enquiryDate,
      'followUpDate': followUpDate,
      'proposalStatus': proposalStatus,
      'dealStage': dealStage,
      'leadReceivedCategory': leadReceivedCategory,

    };
  }

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      employeeName: json['employeeName'],
      clientName: json['clientName'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      address: json['address'],
      pincode: json['pincode'],
      services: json['services'],
      quantity: json['quantity'],
      enquiryDate: json['enquiryDate'],
      followUpDate: json['followUpDate'],
      proposalStatus: json['proposalStatus'],
      dealStage: json['dealStage'],
      leadReceivedCategory: json['leadReceivedCategory'],
    );
  }
}
