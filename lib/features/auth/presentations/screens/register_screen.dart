import 'package:clientes_app/features/auth/presentations/providers/index.dart';
import 'package:clientes_app/features/shared/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroudColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (!context.canPop()) return;
                      context.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 40,
                      color: Colors.white,
                    )),
                Spacer(
                  flex: 1,
                ),
                Text(
                  'Crear Cuenta',
                  style: textStyles.titleLarge?.copyWith(color: Colors.white),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              height: size.height - 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: scaffoldBackgroudColor,
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(100))),
              child: _RegisterForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final loginForm = ref.watch(loginFormProvider);
    final textStyles = Theme.of(context).textTheme;
    final TextEditingController passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 50),
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Text(
            'Nueva Cuenta',
            style: textStyles.titleMedium,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            label: 'Nombre Completo',
            onChanged:
                ref.read(loginFormProvider.notifier).onNameRegisterChange,
            keyboardType: TextInputType.emailAddress,
            errorMessage:
                loginForm.isFormPosted ? loginForm.name.errorMessage : null,
          ),
          SizedBox(
            height: size.height * 0.035,
          ),
          CustomTextFormField(
            label: 'Correo',
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            keyboardType: TextInputType.emailAddress,
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            controller: passwordController,
            label: 'Repita la contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordConfirmed,
            onFieldSummitted: (_) {
              ref.read(loginFormProvider.notifier).onRegisterSubmit();
            },
            errorMessage: loginForm.isFormPosted
                ? loginForm.confirmedPassword.errorMessage
                : null,
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Crear',
              buttonColor: Colors.black,
              onPressed: loginForm.isPosting
                  ? null
                  : ref.read(loginFormProvider.notifier).onRegisterSubmit,
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿Ya tienes cuenta?'),
              TextButton(
                  onPressed: () {
                    if (context.canPop()) {
                      return context.pop();
                    }
                    context.go('/login');
                  },
                  child: Text('Ingresa aquí'))
            ],
          ),
          Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}
