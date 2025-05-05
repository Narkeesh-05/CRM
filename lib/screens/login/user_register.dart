import 'package:demo/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../services/auth_service.dart';
import '../dashboard/dash_board.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _register() async {
    setState(() => _isLoading = true);
    try {
      final user = await _authService.registerWithEmailAndPassword(
        _userNameController.text.trim(),
        _contactController.text.trim(),
        _addressController.text.trim(),
        _pincodeController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dash_Board()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration failed: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    bool isWeb = SizeConfig.screenWidth > 600;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            children: [
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Image.asset(
                'images/logo.jpeg',
                height:
                    isWeb
                        ? SizeConfig.heightMultiplier * 16
                        : SizeConfig.heightMultiplier * 11,
                fit: BoxFit.fill,
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Text(
                'REGISTER HERE',
                style: TextStyle(
                  color: HexColor("#1E4684"),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter your Name',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  color: HexColor("#1E4684"),
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 1),
                              TextFormField(
                                controller: _userNameController,
                                cursorColor: HexColor("#1E4684"),
                                decoration: InputDecoration(
                                  hintText: 'Enter employee name',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        isWeb
                                            ? SizeConfig.heightMultiplier * 2.5
                                            : SizeConfig.heightMultiplier * 1.7,
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    20.0,
                                    16.0,
                                    20.0,
                                    16.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the marketer/employee name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),

                              Text(
                                'Contact Number',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  color: HexColor("#1E4684"),
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 1),
                              TextFormField(
                                controller: _contactController,
                                cursorColor: HexColor("#1E4684"),
                                decoration: InputDecoration(
                                  hintText: 'Enter contact number',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        isWeb
                                            ? SizeConfig.heightMultiplier * 2.5
                                            : SizeConfig.heightMultiplier * 1.7,
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    20.0,
                                    16.0,
                                    20.0,
                                    16.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the contact number';
                                  } else if (value.length != 10) {
                                    return 'Contact number must be exactly 10 digits';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  color: HexColor("#1E4684"),
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 1),
                              TextFormField(
                                controller: _emailController,
                                cursorColor: HexColor("#1E4684"),
                                decoration: InputDecoration(
                                  hintText: 'Enter email id',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        isWeb
                                            ? SizeConfig.heightMultiplier * 2.5
                                            : SizeConfig.heightMultiplier * 1.7,
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    20.0,
                                    16.0,
                                    20.0,
                                    16.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                  // errorText:
                                  //     isEmailValid ? null : 'Enter a valid email',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                // onChanged: validateEmail,
                              ),
                              Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  color: HexColor("#1E4684"),
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              SizedBox(
                                width:
                                    isWeb
                                        ? SizeConfig.widthMultiplier * 27
                                        : double.infinity,
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    hintStyle: TextStyle(
                                      fontSize:
                                          isWeb
                                              ? SizeConfig.heightMultiplier *
                                                  2.2
                                              : SizeConfig.heightMultiplier *
                                                  1.7,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          isWeb
                                              ? BorderRadius.all(
                                                Radius.circular(5.0),
                                              )
                                              : BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                      borderSide: BorderSide(
                                        color: HexColor("#1E4684"),
                                        width: 1.5,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          isWeb
                                              ? BorderRadius.all(
                                                Radius.circular(5.0),
                                              )
                                              : BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                      borderSide: BorderSide(
                                        color: HexColor("#1E4684"),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Text(
                                'Address',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  color: HexColor("#1E4684"),
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 1),
                              TextFormField(
                                controller: _addressController,
                                cursorColor: HexColor("#1E4684"),
                                decoration: InputDecoration(
                                  hintText: 'Enter the address',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        isWeb
                                            ? SizeConfig.heightMultiplier * 2.5
                                            : SizeConfig.heightMultiplier * 1.7,
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    20.0,
                                    16.0,
                                    20.0,
                                    16.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              Text(
                                'Pin code',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  color: HexColor("#1E4684"),
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 1),
                              TextFormField(
                                controller: _pincodeController,
                                cursorColor: HexColor("#1E4684"),
                                decoration: InputDecoration(
                                  hintText: 'Enter the pin code',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        isWeb
                                            ? SizeConfig.heightMultiplier * 2.5
                                            : SizeConfig.heightMultiplier * 1.7,
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    20.0,
                                    16.0,
                                    20.0,
                                    16.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        isWeb
                                            ? BorderRadius.all(
                                              Radius.circular(5.0),
                                            )
                                            : BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                    borderSide: BorderSide(
                                      color: HexColor("#1E4684"),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the pin code';
                                  } else if (value.length != 6) {
                                    return 'Pin code must be exactly 6 digits';
                                  }

                                  return null;
                                },
                              ),

                              SizedBox(height: SizeConfig.heightMultiplier * 4),
                              SizedBox(
                                width:
                                    isWeb
                                        ? SizeConfig.widthMultiplier * 27
                                        : double.infinity,
                                height:
                                    isWeb
                                        ? SizeConfig.heightMultiplier * 7
                                        : SizeConfig.heightMultiplier * 6,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: HexColor("#1E4684"),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _register();
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Already have an account? Login',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 25,
                              ),
                            ],
                          ),
                        ),
                        if (_isLoading)
                          Center(
                            child: Container(
                              width:
                                  isWeb
                                      ? SizeConfig.widthMultiplier * 9
                                      : SizeConfig.widthMultiplier * 25,
                              height:
                                  isWeb
                                      ? SizeConfig.heightMultiplier * 17
                                      : SizeConfig.heightMultiplier * 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.5),

                                color: HexColor("#2e2e2e").withOpacity(1),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircularProgressIndicator(
                                    color: HexColor("#3e66a8"),
                                  ),
                                  const Text(
                                    'Registering...',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }
}
