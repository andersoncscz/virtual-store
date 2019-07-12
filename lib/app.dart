import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/cart_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/login/login_screen.dart';

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, userModel) {
          return ScopedModel<CartModel>(
            model: CartModel(userModel),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: Color.fromARGB(255, 103,58,183),
                primaryColorLight: Color.fromARGB(255, 209,196,233),
                primaryColorDark: Color.fromARGB(255, 81,45,168),
                accentColor: Color.fromARGB(255, 224,64,251),
              ),
              home: LoginScreen()
            ),
          );
        },
      ),
    );
  }
}