import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/user_model.dart';

import 'package:image_picker/image_picker.dart';
import 'package:virtual_store/screens/home/home_screen.dart';
import 'package:virtual_store/widgets/gradient_background_color.dart';

import 'custom_text_form_field.dart';

class LoginSignUpScreen extends StatefulWidget {
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _autoValidate = false;
  File _profilePicture;


  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          GradientBackgroundColor(),
          Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
              padding: EdgeInsets.only(left: 22, right: 22),
              children: <Widget>[
                SizedBox(height: 2),
                Container(
                  height: screenSize.height * 0.3,
                  child: GestureDetector(
                    onTap: _handleProfilePicture,
                    child: Center(
                      child: CircleAvatar(
                        maxRadius: 50,
                        backgroundColor: Theme.of(context).primaryColorLight,
                        backgroundImage: _profilePicture != null ? FileImage(_profilePicture) : AssetImage('assets/images/camera.png'),
                      ),
                    ),
                  ),
                ),
                 _profilePicture == null ? Center(child: Text('Selecione uma foto', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))) : Container(),
                SizedBox(height: 12),
                CustomTextFormField(
                  _nameController, 
                  Icons.account_circle,
                  'Informe o nome', 'Nome', 
                  TextInputType.text, 
                  (text) {
                    if (text.isEmpty || text.length < 6) return 'Nome inválido';
                  }
                ),
                CustomTextFormField(
                  _emailController, 
                  Icons.email, 
                  'Informe o e-mail',
                  'E-mail', 
                  TextInputType.emailAddress,
                  validateEmail
                ),
                CustomTextFormField(
                  _passwordController,
                  Icons.lock,
                  'Informe a senha',
                  'Senha',
                  TextInputType.text,
                  validatePassword,
                  obscureText: true,
                ),
                CustomTextFormField(
                  null,
                  Icons.lock,
                  'Repita a senha',
                  'Senha',
                  TextInputType.text,
                  validateCorrectPassword,
                  obscureText: true,
                ),
                SizedBox(height: 24),
                SizedBox(
                  height: 44,
                  child: UserModel.of(context).isLoading 
                  ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) 
                  : RaisedButton(
                    onPressed: _handleSignUp,
                    color: Colors.white,
                    child: Text('REGISTRAR', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColorDark)),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  void _handleSignUp() async {

    if (!_autoValidate) {
      setState(() {
        _autoValidate = true;
      });
    }

    if (_formKey.currentState.validate()) {
      try {

        Map<String, dynamic> user = {
          'name': _nameController.text,
          'email': _emailController.text,
          'profile_picture': ''
        };

        await UserModel.of(context).signUp(
          user: user,
          password: _passwordController.text,
          onSucess: _onSignUpSucess,
          onFail: _onSignUpFail,
        );        
        
        await UserModel.of(context).uploadProfilePicture(_profilePicture);

      } catch (e) {
        _onSignUpFail();
      }
    }
  }

  void _onSignUpSucess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Cadastrado com sucesso!'),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  void _onSignUpFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Erro ao cadastrar-se!'),
      )
    );
  }

  validateEmail(String email) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!emailValid)
      return 'E-mail inválido';
    return null;
  }

  validatePassword(String password) {
    if (password.length < 6)
      return 'Senha inválida';
    return null;
  }  

  validateCorrectPassword(String password) {
    if (password.isEmpty || password != _passwordController.text)
      return 'Senha não confere';
    return null;
  }

  void _handleProfilePicture() async {
    
    UserModel.of(context).onLoading();
    
    try {
        _profilePicture = await ImagePicker.pickImage(source: ImageSource.gallery);
    } 
    catch (e) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Erro ao tentar acessar a galeria.'),
        )
      );      
    }
    
    UserModel.of(context).onLoadFinished();
  }

}
