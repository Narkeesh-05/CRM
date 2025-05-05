import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdfx/pdfx.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:open_file/open_file.dart';
import '../utils/size_config.dart';

class Document_Upload extends StatefulWidget {
  const Document_Upload({Key? key}) : super(key: key);

  @override
  State<Document_Upload> createState() => _Document_UploadState();
}

class _Document_UploadState extends State<Document_Upload> {
  String? _filePath;
  String? _filePath1;
  String? _fileName;
  String? _fileName1;
  ui.Image? _combinedThumbnail;
  ui.Image? _combinedThumbnail1;
  final TextEditingController _controller = TextEditingController();

  final TextEditingController _controller1 = TextEditingController();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
        _fileName = result.files.single.name;
        _controller.text = _fileName!;
      });

      if (_fileName!.endsWith('.pdf')) {
        await _generateCombinedThumbnail();
      }
    } else {
      print("No file selected.");
    }
  }

  Future<void> pickFile1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      setState(() {
        _filePath1 = result.files.single.path;
        _fileName1 = result.files.single.name;
        _controller1.text = _fileName!;
      });

      if (_fileName1!.endsWith('.pdf')) {
        await _generateCombinedThumbnail1();
      }
    } else {
      print("No file selected.");
    }
  }

  Future<void> _generateCombinedThumbnail() async {
    if (_filePath != null) {
      final document = await PdfDocument.openFile(_filePath!);
      final pageCount = document.pagesCount;
      final List<ui.Image> pageImages = [];

      for (int i = 1; i <= pageCount; i++) {
        final page = await document.getPage(i);
        final pageImage = await page.render(
          width: 200,
          height: 300,
          format: PdfPageImageFormat.png,
        );
        pageImages.add(await _convertToUiImage(pageImage!));
        await page.close();
      }

      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      double yOffset = 0.0;

      for (final ui.Image image in pageImages) {
        canvas.drawImage(image, Offset(0, yOffset), Paint());
        yOffset += image.height.toDouble();
      }

      final ui.Image combinedImage =
      await recorder.endRecording().toImage(200, (300 * pageCount).toInt());

      setState(() {
        _combinedThumbnail = combinedImage;
      });
    }
  }

  Future<void> _generateCombinedThumbnail1() async {
    if (_filePath1 != null) {
      final document1 = await PdfDocument.openFile(_filePath1!);
      final pageCount1 = document1.pagesCount;
      final List<ui.Image> pageImages1 = [];

      for (int i = 1; i <= pageCount1; i++) {
        final page = await document1.getPage(i);
        final pageImage1 = await page.render(
          width: 200,
          height: 300,
          format: PdfPageImageFormat.png,
        );
        pageImages1.add(await _convertToUiImage(pageImage1!));
        await page.close();
      }

      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      double yOffset = 0.0;

      for (final ui.Image image in pageImages1) {
        canvas.drawImage(image, Offset(0, yOffset), Paint());
        yOffset += image.height.toDouble();
      }

      final ui.Image combinedImage1 = await recorder
          .endRecording()
          .toImage(200, (300 * pageCount1).toInt());

      setState(() {
        _combinedThumbnail1 = combinedImage1;
      });
    }
  }

  Future<ui.Image> _convertToUiImage(PdfPageImage pageImage) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(pageImage.bytes, (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  Future<ui.Image> _convertToUiImage1(PdfPageImage pageImage1) async {
    final Completer<ui.Image> completer1 = Completer();
    ui.decodeImageFromList(pageImage1.bytes, (ui.Image img) {
      completer1.complete(img);
    });
    return completer1.future;
  }

  void _openFile() {
    if (_filePath != null) {
      OpenFile.open(_filePath!);
    }
  }

  void _openFile1() {
    if (_filePath1 != null) {
      OpenFile.open(_filePath1!);
    }
  }

  void clearState() {
    setState(() {
      _filePath = null;
      _filePath1 = null;
      _fileName = null;
      _fileName1 = null;
      _combinedThumbnail = null;
      _combinedThumbnail1 = null;
      _controller.clear();
      _controller1.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = SizeConfig.screenWidth > 600;
    SizeConfig.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Proposal Document',
          style: TextStyle(
            color: HexColor("#1E4684"),
          ),
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 1,),
        Container(
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius:isWeb
            ? BorderRadius.all(Radius.circular(5.0))
        : BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(color: HexColor("#1E4684"), width: 1.5),
          ),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _fileName != null
                ? SizedBox(
              height: 65,
              width: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_combinedThumbnail != null &&
                      _fileName!.endsWith('.pdf'))
                    GestureDetector(
                      onTap: _openFile,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor("#1E4684"),
                          ),
                        ),
                        child: RawImage(
                          image: _combinedThumbnail,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  SizedBox(height: SizeConfig.heightMultiplier * 05,),
                  Text(
                    _fileName!,
                    style: TextStyle(
                      fontSize: 8.5,
                      color: HexColor("#1E4684"),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
                : Text(
              'Upload Here',
              style: TextStyle(
                // color: HexColor("#1E4684"),
                color: Colors.grey
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.upload_file,
                size: 25,
                color: HexColor("#1E4684"),
              ),
              onPressed: pickFile,
            ),
          ]),
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 2,),
        Text(
          'Invoice Document',
          style: TextStyle(
            color: HexColor("#1E4684"),
          ),
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 1,),
        Container(
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
         borderRadius:isWeb
    ? BorderRadius.all(Radius.circular(5.0))
        : BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(color: HexColor("#1E4684"), width: 1.5),
          ),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _fileName1 != null
                ? SizedBox(
              height: 65,
              width: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_combinedThumbnail1 != null &&
                      _fileName1!.endsWith('.pdf'))
                    GestureDetector(
                      onTap: _openFile1,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor("#1E4684"),
                          ),
                        ),
                        child: RawImage(
                          image: _combinedThumbnail1,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  SizedBox(height: SizeConfig.heightMultiplier * 05,),
                  Text(
                    _fileName1!,
                    style: TextStyle(
                      fontSize: 8.5,
                      color: HexColor("#1E4684"),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
                : Text(
              'Upload Here',
              style: TextStyle(
                // color: HexColor("#1E4684"),
                color: Colors.grey
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.upload_file,
                size: 25,
                color: HexColor("#1E4684"),
              ),
              onPressed: pickFile1,
            ),
          ]),
        ),
      ],
    );
  }
}

final GlobalKey<_Document_UploadState> documentUploadKey =
GlobalKey<_Document_UploadState>();
