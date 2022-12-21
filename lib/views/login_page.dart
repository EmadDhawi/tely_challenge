import 'package:flutter/material.dart';
import 'package:tely_challenge/services/user_services.dart';

import 'products_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: FlutterLogo(size: 150)),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _pass,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : () => login(),
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    // make request
    setState(() => loading = true);
    final bool result = await UserService.login(_email.text.trim(), _pass.text.trim());
    setState(() => loading = false);

    if (result == true && mounted) {
      // got to home page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ProductsListPage()),
        (route) => false,
      );
    } else {
      // in error show SnackBar
      final errorSnackBar = SnackBar(
        content: Row(
          children: const [
            Icon(
              Icons.error,
              color: Colors.red,
            ),
            SizedBox(width: 10),
            Text(
              'Error - try aging',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }
}
