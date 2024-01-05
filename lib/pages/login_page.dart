import 'package:flutter/material.dart';
import 'package:educafam/components/my_button.dart';
import 'package:educafam/components/my_textfield.dart';
import 'home_page.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

//class LoginPage extends StatelessWidget {
// LoginPage({super.key});
class _LoginPageState extends State<LoginPage> {

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Método para liberar recursos al cerrar la página
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // sign user in method
  void signUserIn(String username, String password) {
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 50,
              ),
              const SizedBox(height: 10),
              Text(
                'Bienvenido!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),

              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 5),

              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Olvidó la Contraseña?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // sign in button
              MyButton(
                onTap: signUserIn,
                usernameController: usernameController,
                passwordController: passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }


}
