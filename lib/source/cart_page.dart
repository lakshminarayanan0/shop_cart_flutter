import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:shop_app/cart_details.dart';
import 'package:shop_app/top_options.dart';
import 'package:badges/badges.dart' as badges;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    getCartDetails();
  }

  Future<Map<String, dynamic>> getCartDetails() async {
    try {
      // print("Starting getCartDetails");
      final apiUrl = "https://dummyjson.com/carts/5";
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // print("Returning data: $data");
        return data as Map<String, dynamic>;
      } else {
        print(
            "Failed to load cart details. Status code: ${response.statusCode}");
        throw "Failed to load cart details. Status code: ${response.statusCode}";
      }
    } catch (err) {
      print("Error in getCartDetails: $err");
      throw err.toString();
    }
  }

  final navs = [
    "women",
    "plus+curve",
    "premium jeans",
    "accessories",
    "swim",
    "activewear",
    "men",
    "girls",
    "sales"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FOREVER 21",
          style: TextStyle(
              // fontFamily: "Pt Sans Narrow",
              fontSize: 25,
              fontWeight: FontWeight.w700,
              letterSpacing: 1),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.account_circle_outlined,
                size: 28,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                size: 28,
              )),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 28,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 5,
                child: badges.Badge(
                  badgeColor: const Color.fromARGB(255, 231, 209, 5),
                  badgeContent: Text(
                    "5",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      //body

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Options(options: navs),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromRGBO(158, 158, 158, 0.6),
                    width: 2,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 8),
              // alignment: Alignment.center,
              // color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 45,
                    ),
                    Text(
                      "My Cart",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //cart area

            Container(
              alignment: Alignment.topLeft,
              // padding: EdgeInsets.all(4),
              // color: Colors.amberAccent,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              child: FutureBuilder(
                future: getCartDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // print("casting");
                    final Map<String, dynamic> data =
                        snapshot.data as Map<String, dynamic>;

                    final id = data['id'];
                    final List<Map<String, dynamic>> products =
                        List<Map<String, dynamic>>.from(data['products']);
                    final total = double.parse(data['total'].toString());
                    final discountedTotal =
                        double.parse(data['discountedTotal'].toString());
                    final userId = data['userId'];
                    final totalProducts = data['totalProducts'];
                    final totalQuantity = data['totalQuantity'];

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      // color: const Color.fromARGB(255, 175, 149, 76),
                      child: CartDetails(
                        id: id,
                        products: products,
                        total: total,
                        discountedTotal: discountedTotal,
                        userId: userId,
                        totalProducts: totalProducts,
                        totalQuantity: totalQuantity,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
