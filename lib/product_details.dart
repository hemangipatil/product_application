import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:product_application/Model/product_model_class.dart';
import 'package:product_application/base_client/base_client_class.dart';

class ProductDetails extends StatefulWidget {
  int productID = 0;

  ProductDetails({Key? key, required int? id}) : super(key: key) {
    productID = id!;
  }

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductModel? productDetails = null;

  @override
  void initState() {
    super.initState();
    fetchPropertyDetails();
  }

  fetchPropertyDetails() async {
    var response = await APIInterFace().getProductDetails(widget.productID);
    setState(() {
      productDetails = ProductModel.fromJson(jsonDecode(response));
      print("Product Details: ${productDetails!.title!}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Product Details")),
      ),
      body: productDetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey.shade300,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Image.network(
                      productDetails!.image!,
                      fit: BoxFit.contain,
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey.shade300,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(productDetails!.title!),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey.shade300,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text("\$ " + productDetails!.price!.toString()),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey.shade300,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Category:- " + productDetails!.category!.toString()),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey.shade300,
                    ),
                    child: RichText(
                      overflow: TextOverflow.fade,
                      text: TextSpan(text: productDetails!.description!),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text("Rating:- " +
                          productDetails!.rating!.rate.toString()),
                      SizedBox(
                        width: 30,
                      ),
                      Text("Review:- " +
                          productDetails!.rating!.count.toString()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Add To Card"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Buy Now"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
