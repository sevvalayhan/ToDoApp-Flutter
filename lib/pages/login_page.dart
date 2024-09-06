import 'package:flutter/material.dart';
import 'package:todo_app_comp/constants/my_text_field.dart';
import 'package:todo_app_comp/widgets/custom_paddings.dart';
import 'package:todo_app_comp/widgets/custom_sign_in_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHidden = true;

  void _signIn() {}

  void _changeVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: PercentPadding.symmetric(context, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                "To Do App",
                style: TextStyle(
                    fontFamily: 'Huglove',
                    fontSize: 50,
                    color: Colors.pink[400]),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text("Welcome your app",
                style: TextStyle(color: Colors.grey.shade500)),
            const SizedBox(
              height: 50,
            ),
            MyTextField(
                obscureText: false,
                controller: userNameController,
                hintText: "User Name",
                labelText: "User Name"),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                suffix: IconButton(
                  
                  padding: EdgeInsets.zero,
                  onPressed: _changeVisibility,
                  // style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  icon: Icon(
                    isHidden ? Icons.visibility : Icons.visibility_off,
                    color: Colors.pink,
                  ),
                ),
                obscureText: isHidden,
                controller: passwordController,
                hintText: "Password",
                labelText: "Password"),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: PercentPadding.symmetric(context, vertical: 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey.shade400),
                      ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _signIn();
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: Colors.pink.shade600,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                    child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )),
              ),
            ),
            //  const SizedBox(height: 5,),
            TextButton(onPressed: () {}, child: const Text("Sign Up")),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 0.5,
                )),
                SizedBox(
                  width: 5,
                ),
                Text("Or continue with"),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Divider(
                  thickness: 0.5,
                ))
              ],
            ),
            //const SquareTile()
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  PercentPadding.symmetric(context, vertical: 5, horizontal: 5),
              child: const CustomSocialSignInOptions(),
            )
          ],
        ),
      ),
    ));
  }
}
