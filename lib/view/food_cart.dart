import 'package:add_food_w_provider/provider/food.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodCart extends StatefulWidget {
  final String title;
  const FoodCart({super.key, required this.title});

  @override
  State<FoodCart> createState() => _FoodCartState();
}

class _FoodCartState extends State<FoodCart> {
  @override
  Widget build(BuildContext context) {
    final getMyCart = context.watch<FoodProvider>().getMyCart;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: getMyCart.length,
              itemBuilder: (context, index) {
                final currentFood = getMyCart[index];
                return Card(
                  key: ValueKey(currentFood.id),
                  color: Colors.black,
                  shadowColor: Colors.blue,
                  elevation: 7.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        currentFood.id.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      currentFood.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${currentFood.price.toString()} £",
                      style: TextStyle(color: Colors.grey.shade200),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Expanded(
                child: StreamBuilder<double>(
                  stream: context.read<FoodProvider>().getPrice(getMyCart),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(
                        "${snapshot.data} £",
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
