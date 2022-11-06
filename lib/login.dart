import 'package:flutter/material.dart';
import 'package:product_application/product_details.dart';
import 'package:product_application/product_list_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  late String _email,_pass;
  bool _isObscure = true;
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Login Page")
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Container(
            child: Center(child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
          ),
          SizedBox(height: 30,),
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter user name or Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlue.shade600,
                          width: 2,
                        ),
                      ),
                      labelText: 'Email',
                    ),
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlue.shade600,
                            width: 2,
                          ),
                        ),
                        labelText: 'Password',
                        // this button is used to toggle the password visibility
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProductList()),
                          );

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')),

                          //);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
