// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart'; // استيراد المكتبة

// class ArticleDetailScreen extends StatefulWidget {
//   final String url;

//   const ArticleDetailScreen({super.key, required this.url});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
// }

// class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // تهيئة WebView في حالة بدء الشاشة
//     WebView.platform = WebView(); // دعم WebView على Android
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Article Details')),
//       body: WebView(
//         initialUrl: widget.url, // الرابط الذي سيتم تحميله في WebView
//         javascriptMode:
//             JavascriptMode.unrestricted, // السماح باستخدام JavaScript
//       ),
//     );
//   }
// }
