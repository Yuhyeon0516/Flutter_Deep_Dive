import 'dart:convert';

import 'package:delivery/common/component/custom_text_form_field.dart';
import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/dio/dio_provider.dart';
import 'package:delivery/common/layout/default_layout.dart';
import 'package:delivery/common/secure_storage/secure_storage_provider.dart';
import 'package:delivery/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = ref.read(dioProvider);

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(
                  height: 16,
                ),
                const _SubTitle(),
                Center(
                  child: Image.asset(
                    'asset/img/misc/logo.png',
                    width: MediaQuery.of(context).size.width / 3 * 2.5,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // id:pw
                    final rawString = '$username:$password';

                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode(rawString);

                    final res = await dio.post(
                      'http://$ip:3000/auth/login',
                      options: Options(
                        headers: {
                          'authorization': 'Basic $token',
                        },
                      ),
                    );

                    final refreshToken = res.data['refreshToken'];
                    final accessToken = res.data['accessToken'];

                    final storage = ref.read(secureStorageProvider);

                    await storage.write(
                      key: REFRESH_TOKEN_KEY,
                      value: refreshToken,
                    );
                    await storage.write(
                      key: ACCESS_TOKEN_KEY,
                      value: accessToken,
                    );

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const RootTab(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('로그인'),
                ),
                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
