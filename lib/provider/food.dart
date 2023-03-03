import 'dart:math';

import 'package:add_food_w_provider/model/food_model.dart';
import 'package:flutter/cupertino.dart';

List<Food> myInitialData = List.generate(
  50,
  (index) => Food(
    id: index,
    name: 'Food $index',
    price: Random().nextInt(100) + 50,
  ),
);

class FoodProvider extends ChangeNotifier {
  final List<Food> initalData = myInitialData;
  List<Food> get myFood => initalData;

  List<Food> myCart = [];
  List<Food> get getMyCart => myCart;

  void addToCart(Food food) {
    getMyCart.add(food);
    notifyListeners();
  }

  Stream<double> getPrice(List<Food> food) async* {
    double total = 0;
    for (var i = 0; i < food.length; i++) {
      total += food[i].price;
    }
    print(total);
    yield total;
  }
}
