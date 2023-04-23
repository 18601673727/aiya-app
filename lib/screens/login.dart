import 'package:aiya/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login extends HookConsumerWidget {
  const Login({super.key});
  static const route = 'login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/login-background.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.black12,
                // Theme.of(context).primaryColor,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(30),
                  RichText(
                    text: const TextSpan(
                      text: '即刻登录，',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.transparent,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: '体验完整的艾桠信息',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.transparent,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  addVerticalSpace(10),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '文件安全',
                          style: TextStyle(
                            color: Colors.transparent,
                            letterSpacing: 1.5,
                            shadows: const [
                              Shadow(offset: Offset(0, -10), color: Colors.white),
                            ],
                            decorationColor: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
                            decorationThickness: 3,
                          ),
                        ),
                        const TextSpan(
                          text: '服务。',
                          style: TextStyle(
                            color: Colors.transparent,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(offset: Offset(0, -10), color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(children: [
                const TextField(
                  decoration: InputDecoration(
                    hintText: '账号',
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
                  ),
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '密码',
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
                  ),
                ),
                addVerticalSpace(15.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    '提交',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
