import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  TextEditingController urlController = TextEditingController();
  double progress = 0.0;

  /* String? _filePath;

  Future<void> _downloadAndOpenPDF() async {
    // Replace 'YOUR_PDF_URL' with the URL of the PDF you want to download
    const pdfUrl = 'YOUR_PDF_URL';
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/example.pdf';

    // Download the PDF file
    HttpClient().getUrl(Uri.parse(pdfUrl))
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) => response.pipe(File(filePath).openWrite()));

    setState(() {
      _filePath = filePath;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Url',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: urlController,
                decoration: const InputDecoration(hintText: 'Enter Url'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                FileDownloader.downloadFile(
                    url: urlController.text,
                    onDownloadError: (String error) {
                      if (kDebugMode) {
                        print('Download error : $error');
                      }
                    },
                    onDownloadCompleted: (path) {
                      final File file = File(path);
                      print(file);
                      urlController.clear();
                    },
                    onProgress: (fileName, progress) {
                      setState(() {
                        progress = progress;
                      });
                    });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: const Text(
                'Download',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      /*appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: _filePath != null
            ? PDFView(
          filePath: _filePath!,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageSnap: true,
        )
            : ElevatedButton(
          onPressed: _downloadAndOpenPDF,
          child: Text('Download PDF'),
        ),
      ),*/
    );
  }
}
