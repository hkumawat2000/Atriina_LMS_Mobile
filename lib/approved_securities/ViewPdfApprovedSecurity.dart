import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class ViewPdfApprovedSecurity extends StatefulWidget {
  final url;

  ViewPdfApprovedSecurity(this.url);

  @override
  _ViewPdfApprovedSecurityState createState() =>
      _ViewPdfApprovedSecurityState();
}

class _ViewPdfApprovedSecurityState extends State<ViewPdfApprovedSecurity> {
  var connectivity = true;

  @override
  void initState() {
    checkNetwork();
    //TODO: change and handle for android view controller which
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  void checkNetwork() async { //check network connection
    var network = await Utility.isNetworkConnection();
    setState(() {
      connectivity = network;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                children: <Widget>[
                  Image.asset(AssetsImagePath.app_icon, width: 37, height: 37),
                  scripsNameText(Strings.approved_security_pdf),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: connectivity
                    ? widget.url != null
                        ? PDFDocument.fromURL(widget.url)
                        : Center(child: Text(Strings.no_data))
                    : Utility.showToastMessage(Strings.no_internet_message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
