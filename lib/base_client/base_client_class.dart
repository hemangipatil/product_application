import 'package:http/http.dart' as http;

class APIInterFace{
  String baseUrl = "https://fakestoreapi.com/products";

  Future<dynamic> getProductList() async{
     Uri api_uri = Uri.parse(baseUrl);



     var respones = await http.get(api_uri);

     if(respones.statusCode == 200){
       print("respones" + respones.body);
       return respones.body;
     }else{
       return "error";
     }
   }
  Future<dynamic> getProductDetails(int productID) async{
     Uri api_uri = Uri.parse(baseUrl+"/$productID");

     var respones = await http.get(api_uri);

     if(respones.statusCode == 200){
       print("respones" + respones.body);
       return respones.body;
     }else{
       return "error";
     }
   }

}