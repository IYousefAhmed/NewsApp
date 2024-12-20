// استيراد مكتبات Dart وFlutter والمكونات المستخدمة في الكود
import 'package:dio/dio.dart'; // مكتبة Dio للتعامل مع HTTP Requests
import 'package:flutter/material.dart'; // مكتبة تصميم واجهات Flutter
import 'package:news_app/models/article_model.dart'; // استيراد موديل يمثل بيانات المقال
import '../services/news_service.dart'; // استيراد الخدمة التي تجلب الأخبار من الـ API
import 'news_list_view.dart'; // استيراد ويدجت لعرض قائمة الأخبار

// تعريف ويدجت NewsListViewBuilder كـ StatefulWidget
class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});

  final String
  category; // متغير لتحديد التصنيف الخاص بالأخبار (مثل رياضة أو تكنولوجيا)

  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState(); // إنشاء الحالة الخاصة بالويدجت
}

// حالة ويدجت NewsListViewBuilder
class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  late Future<List<ArticleModel>>
  future; // تعريف متغير Future لتخزين البيانات القادمة من الـ API

  @override
  void initState() {
    super.initState();
    // يتم تنفيذ الكود هنا عند إنشاء الويدجت لأول مرة
    Dio dio =
        NewsService.createDio(); // إنشاء كائن Dio باستخدام إعدادات مخصصة من NewsService
    future = NewsService(dio).getTopHeadlines(category: widget.category);
    // تخزين العملية غير المتزامنة التي تجلب الأخبار بناءً على التصنيف
  }

  @override
  Widget build(BuildContext context) {
    // استخدام FutureBuilder لمراقبة حالة العملية غير المتزامنة
    return FutureBuilder<List<ArticleModel>>(
      future: future, // العملية التي يتم مراقبتها (جلب البيانات من الـ API)
      builder: (context, snapshot) {
        // التحقق من حالة العملية (snapshot)

        if (snapshot.connectionState == ConnectionState.waiting) {
          // إذا كانت العملية في حالة انتظار (تحميل البيانات)
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ), // عرض مؤشر تحميل دائري
          );
        } else if (snapshot.hasError) {
          // إذا حدث خطأ أثناء جلب البيانات
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0), // إضافة مسافة حول النص
              child: Text(
                'Oops! There was an error, please try again later.', // رسالة الخطأ
                style: TextStyle(color: Colors.red, fontSize: 16), // تنسيق النص
                textAlign: TextAlign.center, // جعل النص في منتصف الشاشة
              ),
            ),
          );
        } else if (snapshot.hasData) {
          // إذا تم جلب البيانات بنجاح
          return NewsListView(articles: snapshot.data!);
          // تمرير قائمة الأخبار إلى ويدجت NewsListView لعرضها
        } else {
          // إذا لم يتم العثور على أي بيانات
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0), // إضافة مسافة حول النص
              child: Text(
                'No articles found for this category.', // رسالة تفيد بعدم وجود مقالات
                style: TextStyle(fontSize: 16), // تنسيق النص
                textAlign: TextAlign.center, // جعل النص في منتصف الشاشة
              ),
            ),
          );
        }
      },
    );
  }
}
