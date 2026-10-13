import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/index.dart';
import '../providers/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackGround = Theme.of(context).scaffoldBackgroundColor;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            Spacer(),
            Icon(
              Icons.production_quantity_limits_rounded,
              color: Colors.white,
              size: 100,
            ),
            Spacer(),
            Container(
              height: size.height - 260,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: scaffoldBackGround,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(100))),
              child: _LoginForm(),
            )
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    ref.listen(authProvider, (prev, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });

    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text('login'.tr(), style: textStyles.titleLarge),
          SizedBox(
            height: 50,
          ),
          CustomTextFormField(
            label: 'email'.tr(),
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            label: 'password'.tr(),
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            onFieldSummitted: (_) {
              ref.read(loginFormProvider.notifier).onFormSubmit();
            },
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: CustomFilledButton(
              text: 'accept'.tr(),
              buttonColor: Colors.black87,
              onPressed: loginForm.isPosting
                  ? null
                  : ref.read(loginFormProvider.notifier).onFormSubmit,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('have.account'.tr()),
              TextButton(
                  onPressed: () {
                    context.push('/register');
                  },
                  child: Text('singin'.tr()))
            ],
          ),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}
