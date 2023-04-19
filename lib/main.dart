import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:power_file_view/power_file_view.dart';
import 'package:aiya/power_file_view_page.dart';

import 'permission_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PowerFileViewManager.initLogEnable(true, true);
  PowerFileViewManager.initEngine();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

const List<String> files = [
  "https://www.xiangmin.net/downloads/test.pdf",
  "https://www.xiangmin.net/downloads/test.docx",
  "https://www.xiangmin.net/downloads/test.doc",
  "https://www.xiangmin.net/downloads/test.xlsx",
  "https://www.xiangmin.net/downloads/test.xls",
  "https://www.xiangmin.net/downloads/test.pptx",
  "https://www.xiangmin.net/downloads/test.ppt",
  "https://www.xiangmin.net/downloads/test.txt",
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('文件列表'),
      ),
      body: ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            String filePath = files[index];
            final fileName = FileUtil.getFileName(filePath);
            final fileType = FileUtil.getFileType(filePath);
            return Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                onPressed: () async {
                  String savePath = await getFilePath(fileType, fileName);
                  if (context.mounted) {
                    onTap(context, filePath, savePath);
                  }
                },
                child: Text(fileName),
              ),
            );
          }),
    );
  }

  Future onTap(BuildContext context, String downloadUrl, String downloadPath) async {
    bool isGranted = await PermissionUtil.check();

    if (isGranted && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) {
          return PowerFileViewPage(
            downloadUrl: downloadUrl,
            downloadPath: downloadPath,
          );
        }),
      );
    } else {
      debugPrint('no permission');
    }
  }

  Future getFilePath(String type, String assetPath) async {
    final directory = await getTemporaryDirectory();
    return "${directory.path}/fileview/${base64.encode(utf8.encode(assetPath))}.$type";
  }
}
