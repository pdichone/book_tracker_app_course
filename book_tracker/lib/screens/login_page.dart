import 'package:book_tracker/widgets/create_account_form.dart';
import 'package:book_tracker/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreateAccountClicked = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Color(0xffb9c2d1),
              )),
          Text(
            'Sign In',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              SizedBox(
                  width: 300,
                  height: 300,
                  child: isCreateAccountClicked != true
                      ? LoginForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController)
                      : CreateAccountForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController)),
              TextButton.icon(
                  icon: Icon(Icons.portrait_rounded),
                  style: TextButton.styleFrom(
                      primary: Color(0xfffd5b28),
                      textStyle:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                  onPressed: () {
                    setState(() {
                      if (!isCreateAccountClicked) {
                        isCreateAccountClicked = true;
                      } else
                        isCreateAccountClicked = false;
                    });
                  },
                  label: Text(isCreateAccountClicked
                      ? 'Already have an account?'
                      : 'Create Account'))
            ],
          ),
          Expanded(
              flex: 2,
              child: Container(
                color: Color(0xffb9c2d1),
              ))
        ],
      )),
    );
  }
}
