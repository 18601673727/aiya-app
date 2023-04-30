import 'package:aiya/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:aiya/main.dart';
import 'package:aiya/providers/auth.dart';
import 'package:aiya/widgets/common.dart';
import 'package:aiya/providers/hpc.dart';
import 'package:xml/xml.dart';

class Login extends HookConsumerWidget {
  const Login({super.key});
  static const route = 'login';

  errorSnackBar(String text) {
    return SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.pinkAccent,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hpc = ref.watch(hpcProvider);

    final usernameController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');

    final fieldsEmptyState = useState<bool>(true);

    bool areFieldsEmpty() {
      return usernameController.text.toString().isEmpty || passwordController.text.toString().isEmpty;
    }

    useEffect(() {
      usernameController.addListener(() {
        fieldsEmptyState.value = areFieldsEmpty();
      });
      passwordController.addListener(() {
        fieldsEmptyState.value = areFieldsEmpty();
      });
      return null;
    }, [
      usernameController,
      passwordController,
    ]);

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
                TextField(
                  autofocus: true,
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: '账号',
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
                  ),
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: '密码',
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
                  ),
                ),
                addVerticalSpace(15.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fieldsEmptyState.value ? Colors.black26 : Colors.black87,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () async {
                    if (!fieldsEmptyState.value) {
                      // 提交表单
                      final payload = loginPayload('wxm', '1234.Com'); // usernameController.text, passwordController.text
                      final url = Uri.https('drm.aiyainfo.com:9443', '/tvud/rd');
                      final body = {'xmlDoc': payload};
                      final response = await hpc.post(url, body: body);

                      // 检查结果
                      final document = XmlDocument.parse(response.body);

                      final sessionId = document.findAllElements('EnvelopeHeader').first.attributes[3].value;
                      if (context.mounted && sessionId.length != 48) {
                        logger.e('Session Id Invalid: $sessionId');

                        if (sessionId.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar('账号密码错误'));
                        }

                        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar('服务器没有返回合法的SessionId'));
                      }

                      // 缓存 sessionId, displayName
                      await ref.read(sessionIdProvider.notifier).update(sessionId);

                      for (var element in document.findAllElements('PropertyObject')) {
                        if (element.attributes[0].value == 'java.lang.String') {
                          if (element.attributes[1].value == 'displayName') {
                            await ref.read(displayNameProvider.notifier).update(element.attributes[2].value);
                          }
                        }
                      }

                      logger.i('Login success, Session Id: ${ref.watch(sessionIdProvider)}, Display Name: ${ref.watch(displayNameProvider)}');

                      // 完成登录，页面跳转返回
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar('请填写所有必填字段'));
                    }
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
