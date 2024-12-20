// استيراد المكتبات اللازمة
import 'package:dio/dio.dart'; // استيراد مكتبة Dio للتعامل مع طلبات HTTP
import 'package:dio/io.dart'; // استيراد الأدوات المساعدة لـ Dio
import 'dart:io'; // استيراد مكتبة للتعامل مع عمليات الإدخال/الإخراج
import 'package:news_app/models/article_model.dart'; // استيراد نموذج المقال الخاص بالتطبيق

// تعريف فئة خدمة الأخبار
class NewsService {
  final Dio dio; // متغير من نوع Dio للقيام بطلبات HTTP

  NewsService(this.dio); // منشئ الفئة يأخذ كائن Dio

  // دالة ثابتة لإنشاء وإعداد كائن Dio
  static Dio createDio() {
    Dio dio = Dio(); // إنشاء كائن Dio جديد

    // إعداد المحول الخاص بـ HTTP
    dio.httpClientAdapter =
        IOHttpClientAdapter()
          ..createHttpClient = () {
            HttpClient client = HttpClient(); // إنشاء عميل HTTP
            client.badCertificateCallback = (cert, host, port) {
              return true; // قبول جميع الشهادات (للاختبار فقط)
            };
            return client;
          };
    return dio;
  }

  // دالة للحصول على أهم العناوين حسب الفئة
  Future<List<ArticleModel>> getTopHeadlines({required String category}) async {
    try {
      // إجراء طلب GET للحصول على الأخبار
      var response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=be703b1ad2dc40df9728535366e3d3b5&category=$category',
      );

      // تحويل البيانات المستلمة إلى Map
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles =
          jsonData['articles']; // الحصول على قائمة المقالات

      List<ArticleModel> articlesList =
          []; // إنشاء قائمة فارغة لتخزين نماذج المقالات

      // التكرار على كل مقال وتحويله إلى نموذج
      for (var article in articles) {
        ArticleModel articleModel = ArticleModel.fromJson(article);
        // String imageUrl = article['urlToImage'] ?? '';
        // if (imageUrl.isEmpty) {
        //   imageUrl =
        //       'https://via.placeholder.com/150'; // استخدام صورة افتراضية إذا لم تتوفر صورة
        // }

        // // إنشاء نموذج مقال جديد
        // ArticleModel articleModel = ArticleModel(
        //   image: imageUrl,

        //   title:
        //       article['title'] ??
        //       'No Title', // استخدام عنوان افتراضي إذا لم يتوفر عنوان
        //   subTitle: article['description'] ?? 'No Description',
        //   // url:
        //   //     article['url'] ??
        //   //     '', // تمرير الرابط // استخدام وصف افتراضي إذا لم يتوفر وصف
        // );
        articlesList.add(articleModel); // إضافة النموذج إلى القائمة
      }

      return articlesList; // إرجاع قائمة النماذج
    } catch (e) {
      return []; // إرجاع قائمة فارغة في حالة حدوث خطأ
    }
  }
}
