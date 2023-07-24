import 'package:flutter/material.dart';
import 'package:paw_hug/customer_information.dart';

/// LoginFormState widget that represents login form.
class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  /// create email and password controller
  /// Will be used by user for login in and creating new account.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// When the user navigates to the search screen, you can set the focus to
  /// the text field for the search term. This allows the user to start typing
  /// as soon as the screen is visible, without needing to manually tap the text field.
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  /// Dynamic Variable that will be used for
  /// to obscure password information.
  dynamic _isObscured;

  ///  method is called. It is essential to include this line
  ///  to ensure proper functioning of the widget's state.
  ///  Here the obscured variable is set to true so initially the user
  ///  will not be able to see his password.
  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  ///The purpose of calling dispose() on the controllers is to free up
  /// resources and avoid memory leaks when the widget is no longer needed.
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// boolean function to check the email is valid
  isValidEmail(emailController) {
    var email = emailController;
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextFormField(
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'email',
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    emailFocusNode.requestFocus();
                    return 'Please enter email';
                  }
                  return isValidEmail(value) ? null : 'Invalid email';
                },
              ),
              TextFormField(
                obscureText: _isObscured,
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.emailAddress,
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      icon: _isObscured
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      }),
                  hintText: 'password',
                  icon: const Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    passwordFocusNode.requestFocus();
                    return 'Please enter some text';
                  }
                  if (value.length < 6) {
                    passwordFocusNode.requestFocus();
                    return 'Password must be at least 6 characters';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        /// Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Trying to Login')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        minimumSize: const Size(20,40)
                      ),
                      child: const Text('Submit'),
                    ),

                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CustomerForm()),
                          );
                        },

                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),

                        ),
                        minimumSize: const Size(20,40),
                      ),
                        child: const Text('Create account'),


                    ),
                    const SizedBox(height: 10,),
                    const Text('Click Create Account to register for PawHugs Connection',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.indigo,
                      ),
                      textAlign: TextAlign.center,
                    ),


                  ],
                ),
              )

            ]));
  }
}

// Define a custom form widget
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Image(
            image: AssetImage('images/PAWS.jpg'),
          )
        ],
        title: Text(
          'PawHugsConnection',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.indigo.shade900,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/login_background.jpg'),
              fit: BoxFit.fill),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
