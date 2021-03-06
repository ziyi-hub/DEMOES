import 'sample.dart';

class Category {
  String categoryName;
  List<Sample> samples;

  Category({required this.categoryName, required this.samples});

  factory Category.fromJson(Map<String, dynamic> jsonMap) {
    List<dynamic> samplesFromJson = jsonMap["samples"];
    List<Sample> samples = [];
    for (int i = 0; i < samplesFromJson.length; i++) {
      samples.add(new Sample.fromJson(samplesFromJson[i]));
    }

    return Category(categoryName: jsonMap["category_name"], samples: samples);
  }
}
