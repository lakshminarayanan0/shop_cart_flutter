import 'package:flutter/material.dart';
import 'package:shop_app/drop_down_box.dart';

class ProductDetails extends StatefulWidget {
  final int id;
  final String title;
  final double price;
  late int quantity;
  late double total;
  final double discountPercentage;
  final double discountedPrice;
  final String thumbnail;
  final Function(double, bool) onTotalUpdated;

  ProductDetails({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.thumbnail,
    required this.onTotalUpdated,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late int? selectedQuantity;
  late double updatedTotal = widget.total;

  @override
  void initState() {
    selectedQuantity = widget.quantity;
    super.initState();
// updateTotal(selectedQuantity);
  }

  // void updateSubTotal(int? selectedQuantity) {
  //   print("previous total: ${widget.total}");
  //   print("previous quantity: ${widget.quantity}");

  //   setState(() {
  //     widget.quantity = selectedQuantity!;
  //     updatedTotal = selectedQuantity * widget.price;
  //     widget.total = updatedTotal;
  //   });
  // }

  void updateTotal(int? selectedQuantity) {
    int previousQuantity = widget.quantity;
    int diff = selectedQuantity! - previousQuantity;
    double diffAmount = 0;

    print("diff: $diff");

    setState(() {
      widget.quantity = selectedQuantity!;
      updatedTotal = selectedQuantity * widget.price;
      widget.total = updatedTotal;

      if (diff > 0) {
        diffAmount = diff * widget.price;
        print("diff amount: $diffAmount");
        widget.onTotalUpdated(diffAmount, true);
      } else if (diff < 0) {
        diffAmount = (-(diff)) * widget.price;
        print("diff amount: $diffAmount");
        widget.onTotalUpdated(diffAmount, false);
      } else if (diff == 0) {
        widget.onTotalUpdated(0, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
// color: Colors.blue,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Color.fromRGBO(158, 158, 158, 0.6)),
      )),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.15,
            child: Image(
              image: NetworkImage(widget.thumbnail),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
// color: Colors.brown,
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.13,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.title.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          alignment: Alignment.center,
                          child: Text(
                            "Each",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          alignment: Alignment.center,
                          child: Text(
                            "Quantity",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          alignment: Alignment.center,
                          child: Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.13,
                          padding: EdgeInsets.only(left: 10),
// alignment: Alignment.center,
                          child: Text(
                            "Color: Default",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          alignment: Alignment.center,
                          child: Text(
                            "\$${widget.price.toString()}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          alignment: Alignment.center,
                          child: MyDropdown(
                            selectedValue: selectedQuantity,
                            onChanged: (int? value) {
                              setState(() {
                                selectedQuantity = value;
                                // updateSubTotal(selectedQuantity);
                                updateTotal(selectedQuantity);
                              });
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          alignment: Alignment.center,
                          child: Text(
                            "\$${updatedTotal.toString()}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Size: default",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "In stock",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
// color: Colors.grey,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Remove',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Move to wishlist',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Save for later',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
