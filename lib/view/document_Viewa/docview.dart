import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentViewer extends StatefulWidget {
  dynamic data;
  DocumentViewer({super.key, required this.data});

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data['name'].toString(),
          maxLines: 1,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SfPdfViewer.network(
              widget.data['url'],
              key: _pdfViewerKey,
              canShowPageLoadingIndicator: true,
              onDocumentLoadFailed: (details) {
                print(details.description.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}
