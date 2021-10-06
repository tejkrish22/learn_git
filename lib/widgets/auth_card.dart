import 'package:flutter/material.dart';

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); // keyboard automatically closes
    if (isValid) {
      _formKey.currentState.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Username must be atleast 5 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 8) {
                        return 'Password must be atleast 8 characters long';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_isLogin ? 'LogIn' : 'SignUp'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_isLogin
                          ? 'Not Registered yet?'
                          : 'Already registered?'),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState.reset();
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin ? 'SignUp' : 'SignIn'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
