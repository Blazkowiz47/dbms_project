import '/auth/notifiers/auth_notifier.dart';
import '/utils/utils.dart';
import '/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authStateNotifier.notifier);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: smallVP * 2,
            ),
            Container(
              width: buttonFieldWidth,
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign In to continue...",
                style: defaultTextStyle.copyWith(fontSize: bigTextSize),
              ),
            ),
            SizedBox(
              height: smallVP * 2,
            ),
            SizedBox(
              height: buttonFieldHeight,
              width: buttonFieldWidth,
              child: TextFormField(
                controller: authNotifier.emailController,
                decoration: const InputDecoration(
                    hintText: "Enter our email: abs@xyz.com"),
              ),
            ),
            SizedBox(
              height: smallVP,
            ),
            SizedBox(
              height: buttonFieldHeight,
              width: buttonFieldWidth,
              child: TextFormField(
                obscureText: true,
                controller: authNotifier.passController,
                decoration: const InputDecoration(
                    hintText: "Enter atleast 6 character long password"),
              ),
            ),
            SizedBox(
              height: smallVP * 2,
            ),
            GoodButton(
              text: "Log In",
              bgColor: Colors.green,
              textColor: Colors.white,
              onTap: () async {
                final res = await authNotifier.login();
                if (!res) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill the details appropriately.'),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: smallVP,
            ),
            GoodButton(
              text: "Register",
              borderColor: Colors.white,
              textColor: Colors.blue,
              onTap: () {
                authNotifier.gotoRegister();
              },
            ),
          ],
        ),
      ),
    );
  }
}
