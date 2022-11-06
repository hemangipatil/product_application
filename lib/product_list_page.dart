import 'package:flutter/material.dart';
import 'package:product_application/Model/product_model_class.dart';
import 'package:product_application/product_details.dart';

import 'base_client/base_client_class.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // final List<String> title = <String>['Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops', 'Mens Casual Premium Slim Fit T-Shirts', 'Mens Cotton Jacket', 'Mens Casual Slim Fit', 'John Hardy Women\'s Legends Naga Gold & Silver Dragon Station Chain Bracelet', 'Solid Gold Petite Micropave', 'White Gold Plated Princess', 'Pierced Owl Rose Gold Plated Stainless Steel Double'];
  // final List<double> price = <double>[109.95, 22.3, 55.99, 15.99, 695, 168, 168, 10.99];
  TextEditingController controller = new TextEditingController();

  List<ProductModel> mainProductList = [];
  List<ProductModel> productList = [];
  bool isLoad = false;

  onSearchTextChanged(String text) async {

    List<ProductModel> searchProductList = [];
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    print("SearchText: main size ${mainProductList.length}");
    mainProductList.forEach((productDetail) {
      if (productDetail.title!.toLowerCase().contains(text.toLowerCase())) {
        searchProductList.add(productDetail);
      }
    });

    print("SearchText: text: $text");
    print("SearchText:  size: ${searchProductList.length}");
    setState(() {
      productList.clear();
      productList.addAll(searchProductList);
    });
  }

  fetchData() async {
    List<ProductModel> productListTemp = [];
    var response = await APIInterFace().getProductList();
    productListTemp = productModelFromJson(response);

    setState(() {
      isLoad = true;
      productList.addAll(productListTemp);
      mainProductList.addAll(productListTemp);
      
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Column(
        children: <Widget> [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: TextFormField(
              controller: controller,
              onChanged: onSearchTextChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightBlue.shade600,
                    width: 2,
                  ),
                ),
                labelText: 'Search',
              ),
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
          Expanded(
            child : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                return productList.length == 0 && isLoad
                    ? Center(
                        child: Text("No Data"),
                      )
                    : !isLoad
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(0, 0), // Shadow position
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.network(productList[index].image!),
                              ),
                              title: Container(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: productList[index].title!,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                "\$" + productList[index].price.toString(),
                              ),

                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProductDetails(id: productList[index].id,)),
                                );
                              },
                            ),
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}
