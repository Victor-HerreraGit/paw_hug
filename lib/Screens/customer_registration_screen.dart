import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  dynamic _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
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
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        UserCredential userCredential =
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        // User registration successful, navigate to the next screen.
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NextScreen()),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          // Handle weak password error.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Weak password. Please choose a stronger password.')),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          // Handle email already in use error.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('The email is already in use. Please use a different email.')),
                          );
                        } else {
                          // Handle other errors.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('An error occurred. Please try again later.')),
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    minimumSize: const Size(20, 40),
                  ),
                  child: const Text('Create account'),
                ),
              ],
            ),
          ),
          // Rest of the code remains the same
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {


  @override
  LoginFormState createState() => LoginFormState();
}

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  // Replace this with the screen you want to navigate to after successful registration.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Next Screen!'),
      ),
    );
  }
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
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Login',
                    style: Theme.of(context).textTheme.bodyLarge
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CustomerForm extends StatefulWidget {
  const CustomerForm({Key? key}) : super(key: key);

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> addCustomerData() {
    // Call the user's CollectionReference to add a new user
    return FirebaseFirestore.instance.collection('customers').add({
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
    })
        .then((value) => print("Customer Added"))
        .catchError((error) => print("Failed to add customer: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Form'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your phone number',
                    labelText: 'Phone',
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Password',
                    labelText: 'Password',
                  ),
                ),
                ElevatedButton(
                  onPressed: addCustomerData,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


