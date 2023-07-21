import 'package:flutter/material.dart';
import 'register.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        actions: const [
          Image(
            image: AssetImage('images/PAWS.jpg'),
          )
        ],
        centerTitle: true,
        title: const Text(
          'PawHugConnection',
          style: TextStyle(
              fontFamily: 'Andrina',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/login_background.jpg'),
          fit: BoxFit.fill)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.indigo[500],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement your login logic here
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to the registration screen when clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: const Text('Register new account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
