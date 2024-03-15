import 'package:flutter/material.dart';
import 'package:shop_app/product_details.dart';

class CartDetails extends StatefulWidget {
  final int id;
  final List<Map<String, dynamic>> products;
  late double total;
  late double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  CartDetails({
    super.key,
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  @override
  void initState() {
    super.initState();
  }

  void updateTotal(double newTotal, bool isAdd) {
    print("previous overall total: ${widget.total}");
    print("updating total $newTotal");
    setState(() {
      isAdd ? widget.total += newTotal : widget.total -= newTotal;
      widget.discountedTotal = widget.total * 0.84;
    });
    print("updated overall total: ${widget.total}");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // products

        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border(
                top: BorderSide(color: Color.fromRGBO(158, 158, 158, 0.6)),
              )),
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.products.length,
                          itemBuilder: (context, index) {
                            var product = widget.products[index];

                            return ProductDetails(
                              id: product['id'],
                              title: product['title'],
                              price: double.parse(product['price'].toString()),
                              quantity:
                                  int.parse(product['quantity'].toString()),
                              total: double.parse(product['total'].toString()),
                              discountPercentage: double.parse(
                                  product['discountPercentage'].toString()),
                              discountedPrice: double.parse(
                                  product['discountedPrice'].toString()),
                              thumbnail: product['thumbnail'],
                              onTotalUpdated: updateTotal,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Color.fromRGBO(158, 158, 158, 0.6)),
              )),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 8,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No.of.items: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.products.length.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(158, 158, 158, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\$${widget.total.toString()}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),

        // //summary

        Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: MediaQuery.of(context).size.width * 0.3,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Promo Code",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(0),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color.fromRGBO(158, 158, 158, 0.6),
                                ),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("Submit"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(8)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping Cost: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(158, 158, 158, 1),
                            ),
                          ),
                          Text(
                            "TBD",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(158, 158, 158, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(158, 158, 158, 1),
                            ),
                          ),
                          Text(
                            "- \$${(widget.total - widget.discountedTotal).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(158, 158, 158, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(158, 158, 158, 1),
                            ),
                          ),
                          Text(
                            "TBD",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(158, 158, 158, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Estimated Total: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            " \$${widget.discountedTotal.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    (widget.discountedTotal >= 50)
                        ? "Enjoy your free shipping!"
                        : "You're ${50 - widget.discountedTotal} away from free shipping!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.green),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.yellow),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Check Out",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
