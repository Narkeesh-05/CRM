// import 'package:demo/screens/client/lead_to_client.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/size_config.dart';
import '../dashboard/dash_board.dart';
import '../../model/lead_data.dart';

class Lead_Details extends StatelessWidget {
  final LeadData leadData;

  Lead_Details({required this.leadData});

  @override
  Widget build(BuildContext context) {
    bool isWeb = SizeConfig.screenWidth > 600;
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#1E4684"),
        elevation: 3,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Lead Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        // padding: const EdgeInsets.all(16.0),
        padding: EdgeInsets.only(
          top: SizeConfig.heightMultiplier * 2,
          left:
              isWeb
                  ? SizeConfig.widthMultiplier * 35
                  : SizeConfig.widthMultiplier * 2,
          right:
              isWeb
                  ? SizeConfig.widthMultiplier * 35
                  : SizeConfig.widthMultiplier * 2,
          bottom: SizeConfig.heightMultiplier * 4,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lead Name:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'Contact Number:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'Pincode:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'Services:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'Quantity:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'Enquiry Date:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'FollowUp Date:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'ProposalStatus:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'Lead Stage:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      const Text(
                        'Lead Received Category:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: SizeConfig.heightMultiplier * 1),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leadData.leadName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.contactNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.email,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.address,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.pincode,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.services,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.quantity,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.enquiryDate,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.followUpDate,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.proposalStatus,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.leadStage,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Text(
                          leadData.leadReceivedCategory,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      backgroundColor: HexColor("#1E4684"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dash_Board(),
                        ),
                      );
                    },
                    child: const Text(
                      'Go Home ->',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
