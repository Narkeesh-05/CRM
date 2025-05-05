import 'package:demo/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../services/auth_service.dart';
import '../dashboard/dash_board.dart';
import '../login/user_register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  void _login() async {
    setState(() => _isLoading = true);
    try {
      final user = await _authService.signInWithEmailAndPassword(
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
      ).showSnackBar(SnackBar(content: Text("Login failed: $e")));
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
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        'COMMON CRM',
                        style: TextStyle(
                          color: HexColor("#1E4684"),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      SizedBox(
                        width:
                            isWeb
                                ? SizeConfig.widthMultiplier * 27
                                : double.infinity,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize:
                                  isWeb
                                      ? SizeConfig.heightMultiplier * 2.5
                                      : SizeConfig.heightMultiplier * 2,
                            ),
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              fontSize:
                                  isWeb
                                      ? SizeConfig.heightMultiplier * 2.2
                                      : SizeConfig.heightMultiplier * 1.7,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide: BorderSide(
                                color: HexColor("#1E4684"),
                                width: 1,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
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
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize:
                                  isWeb
                                      ? SizeConfig.heightMultiplier * 2.5
                                      : SizeConfig.heightMultiplier * 2,
                            ),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              fontSize:
                                  isWeb
                                      ? SizeConfig.heightMultiplier * 2.2
                                      : SizeConfig.heightMultiplier * 1.7,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide: BorderSide(
                                color: HexColor("#1E4684"),
                                width: 1,
                              ),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
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
                              _login();
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      Text(
                        'If you already registered login here',
                        style: TextStyle(color: HexColor("#1E4684")),
                      ),
                      Text('Or'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                          print('Button pressed!');
                        },
                        child: Text(
                          'Register Here',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicator(color: HexColor("#3e66a8")),
                          const Text(
                            'Loading',
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
