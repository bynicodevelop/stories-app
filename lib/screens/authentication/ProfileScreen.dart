import 'package:app/widgets/forms/EmailInput.dart';
import 'package:app/widgets/forms/MainButton.dart';
import 'package:app/widgets/forms/PasswordInput.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ProfileScreen(),
    );
  }

  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                EmailInput(
                  errorMessage: '',
                  label: 'Email',
                  onValidatedValue: (value) => null,
                ),
                PasswordInput(
                  errorMessage: '',
                  label: 'Password',
                  onValidatedValue: (value) => null,
                ),
                MainButton(
                  label: 'Mettre à jour',
                  onPressed: () => null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
