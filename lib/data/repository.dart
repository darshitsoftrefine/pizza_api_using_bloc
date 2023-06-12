import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

abstract class FoodRepository {
  Future<List<Recipes>?> getFoods();
}

class FoodRepositories extends FoodRepository {
  @override
  Future<List<Recipes>?> getFoods() async {
    var response = await http.get(
        Uri.parse('https://forkify-api.herokuapp.com/api/search?q=pizza#'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<Recipes>? recipes = Pizza.fromJson(data).recipes;
      return recipes;
    } else {
      throw Exception('Failed');
    }
  }
}