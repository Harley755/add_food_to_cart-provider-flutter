import 'package:add_food_w_provider/provider/food.dart';
import 'package:add_food_w_provider/view/food_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var myAllFood = context.watch<FoodProvider>().myFood;
    var mySelectedFood = context.watch<FoodProvider>().myCart;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FoodCart(title: "Food Cart"),
                    ));
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      context.read<FoodProvider>().myCart.length.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: ListView.builder(
          itemCount: myAllFood.length,
          itemBuilder: (context, index) {
            final currentFood = myAllFood[index];
            return Card(
              key: ValueKey(currentFood.name),
              elevation: 4.0,
              shadowColor: Colors.white,
              color: Colors.black,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(currentFood.id.toString()),
                ),
                title: Text(
                  currentFood.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                subtitle: Text(
                  "${currentFood.price.toString()} £",
                  style: TextStyle(color: Colors.grey.shade200),
                ),
                trailing: TextButton(
                  onPressed: () {
                    if (!mySelectedFood.contains(currentFood)) {
                      context.read<FoodProvider>().addToCart(currentFood);
                    }
                  },
                  child: mySelectedFood.contains(currentFood)
                      ? const Icon(Icons.check)
                      : const Text("ADD"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
