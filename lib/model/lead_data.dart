class LeadData {
  String employeeName;
  String leadName;
  String contactNumber;
  String email;
  String address;
  String pincode;
  String services;
  String quantity;
  String enquiryDate;
  String followUpDate;
  String proposalStatus;
  String leadStage;
  String leadReceivedCategory;

  LeadData({
    required this.employeeName,
    required this.leadName,
    required this.contactNumber,
    required this.email,
    required this.address,
    required this.pincode,
    required this.services,
    required this.quantity,
    required this.enquiryDate,
    required this.followUpDate,
    required this.proposalStatus,
    required this.leadStage,
    required this.leadReceivedCategory,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeName': employeeName,
      'clientName': leadName,
      'contactNumber': contactNumber,
      'email': email,
      'address': address,
      'pincode': pincode,
      'services': services,
      'quantity': quantity,
      'enquiryDate': enquiryDate,
      'followUpDate': followUpDate,
      'proposalStatus': proposalStatus,
      'dealStage': leadStage,
      'leadReceivedCategory': leadReceivedCategory,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory LeadData.fromJson(Map<String, dynamic> json) {
    return LeadData(
      employeeName: json['employeeName'],
      leadName: json['clientName'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      address: json['address'],
      pincode: json['pincode'],
      services: json['services'],
      quantity: json['quantity'],
      enquiryDate: json['enquiryDate'],
      followUpDate: json['followUpDate'],
      proposalStatus: json['proposalStatus'],
      leadStage: json['dealStage'],
      leadReceivedCategory: json['leadReceivedCategory'],
    );
  }
}
