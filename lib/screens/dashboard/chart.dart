import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:demo/utils/size_config.dart';

enum LegendShape { circle, rectangle }

class Lead_Chart extends StatefulWidget {
  final int noOfLeads;
  final int closedLeads;
  final int processLeads;
  final int initialLevelLeads;
  final int proposalSentLeads;

  const Lead_Chart({
    Key? key,
    required this.noOfLeads,
    required this.closedLeads,
    required this.processLeads,
    required this.initialLevelLeads,
    required this.proposalSentLeads,
  }) : super(key: key);

  @override
  Lead_ChartState createState() => Lead_ChartState();
}

class Lead_ChartState extends State<Lead_Chart> {
  late Map<String, double> dataMap;

  final legendLabels = {
    "No Of Leads": "No Of Leads",
    "Closed Leads": "Closed Leads",
    "Process Leads": "Process Leads",
    "Initial Level": "Initial Level",
    "Proposal Sent": "Proposal Sent",
  };

  final colorList = [
    Color.fromARGB(128, 30, 70, 132),
    Colors.red.shade200,
    Colors.yellow.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
  ];

  @override
  void initState() {
    super.initState();
    updateDataMap();
  }

  void updateDataMap() {
    dataMap = {
      "No Of Leads": widget.noOfLeads.toDouble(),
      "Closed Leads": widget.closedLeads.toDouble(),
      "Process Leads": widget.processLeads.toDouble(),
      "Initial Level": widget.initialLevelLeads.toDouble(),
      "Proposal Sent": widget.proposalSentLeads.toDouble(),
    };
  }

  @override
  void didUpdateWidget(covariant Lead_Chart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.noOfLeads != oldWidget.noOfLeads ||
        widget.closedLeads != oldWidget.closedLeads ||
        widget.processLeads != oldWidget.processLeads ||
        widget.initialLevelLeads != oldWidget.initialLevelLeads ||
        widget.proposalSentLeads != oldWidget.proposalSentLeads) {
      updateDataMap();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWeb = constraints.maxWidth > 600;

        final double chartWidth = isWeb
            ? SizeConfig.screenWidth * 0.20
            : SizeConfig.screenWidth * 0.6;

        final double chartHeight = isWeb
            ? SizeConfig.screenHeight * 0.4
            : SizeConfig.screenHeight * 0.25;

        final chart = Align(
          alignment: Alignment.center,
          child: CustomPaint(
            size: Size(chartWidth, chartHeight),
            painter: OutlinePieChartPainter(dataMap: dataMap, colorList: colorList),
          ),
        );

        final legends = Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: dataMap.keys.map((key) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width:isWeb? SizeConfig.widthMultiplier * 1:7,
                  height:isWeb? SizeConfig.heightMultiplier * 2.5:7,
                  color: colorList[dataMap.keys.toList().indexOf(key)],
                ),
                const SizedBox(width: 6),
                Text(
                  legendLabels[key]!,
                  style: TextStyle(
                    color: HexColor("#1E4684"),
                    fontSize:isWeb? SizeConfig.textMultiplier * 2:12,
                  ),
                ),
              ],
            );
          }).toList(),
        );

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              chart,
              const SizedBox(height: 24),
              legends,
            ],
          ),
        );
      },
    );
  }
}

class OutlinePieChartPainter extends CustomPainter {
  final Map<String, double> dataMap;
  final List<Color> colorList;

  OutlinePieChartPainter({required this.dataMap, required this.colorList});

  @override
  void paint(Canvas canvas, Size size) {
    final paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.white;

    final total = dataMap.values.reduce((a, b) => a + b);
    double startAngle = -math.pi / 2;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final radius = size.width / 2;

    int i = 0;
    dataMap.forEach((key, value) {
      final sweepAngle = (value / total) * 2 * math.pi;

      final paintFill = Paint()
        ..style = PaintingStyle.fill
        ..color = colorList[i % colorList.length];

      canvas.drawArc(rect, startAngle, sweepAngle, true, paintFill);
      canvas.drawArc(rect, startAngle, sweepAngle, true, paintStroke);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '${(value / total * 100).toStringAsFixed(1)}%',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final x = size.width / 2 +
          (radius + 10) * math.cos(startAngle + sweepAngle / 2) -
          textPainter.width / 2;
      final y = size.height / 2 +
          (radius + 10) * math.sin(startAngle + sweepAngle / 2) -
          textPainter.height / 2;

      textPainter.paint(canvas, Offset(x, y));
      startAngle += sweepAngle;
      i++;
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
