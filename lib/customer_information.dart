import 'package:flutter/material.dart';

class CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  bool isValidNum(String value) {
    if (int.tryParse(value) == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Information"),
      ),
      body: Stack(children: <Widget>[
        const Image(
          image: AssetImage(
            'images/PAWS.jpg',
          ),
          fit: BoxFit.cover,
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              TextFormField(
                controller: firstNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter First Name';
                  }
                },
                style: const TextStyle(
                    fontFamily: 'Andrina.ttf',
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
              TextFormField(
                controller: lastNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Last Name';
                  }
                },
              ),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(hintText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address';
                  }
                },
              ),
              TextFormField(
                controller: cityController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter City';
                  }
                },
              ),
              TextFormField(
                controller: stateController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Phone Number';
                  }
                },
              ),
              TextFormField(
                controller: zipController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Zip Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Zip Code';
                  } else if (!isValidNum(value!)) {
                    return 'Please Enter Numbers For Zip Code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Phone Number';
                  } else if (!isValidNum(value!)) {
                    return 'Please Enter Only Numbers';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Do something if the form is valid...
                        print('Form is valid');
                      }
                    },
                    child: const Text('Submit')),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  CustomerFormState createState() => CustomerFormState();
}
