import '../models/images.dart';
import 'package:http/http.dart' as http;

class Services{
  static Future<List<Result>> getImages(String searchWord) async{
    final String url = 'https://api.unsplash.com/search/photos?query=$searchWord&client_id=WNmxNtUOXRe2g8tmb8nKoR5alE3n5xNXNlsNz4IA0tI';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      MyImage images = imagesFromJson(response.body);
      if (images.results == null) {
        return <Result>[];
      }  else
        {
          return images.results;
        }
    }else{
      return <Result>[];
    }
  }
}