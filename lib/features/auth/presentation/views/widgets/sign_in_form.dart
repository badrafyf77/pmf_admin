import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/app_logo.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/text_field.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/helpers/validators.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/auth/presentation/manager/sign%20in%20bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            SizedBox(
              width: size.width * 0.32,
              child: const AppLogo(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'E-mail',
              style: Styles.normal16,
            ),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
              width: size.width * 0.32,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrer votre e-mail';
                } else if (!value.isValidEmail()) {
                  return 'vérifier votre e-mail';
                }
                return null;
              },
              hintText: 'Email',
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Mot de passe',
              style: Styles.normal16,
            ),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
              isPass: true,
              width: size.width * 0.32,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrer votre mot de passe';
                } else if (value.length < 6) {
                  return 'Mot de passe doit être d\'au moins 6 caractères';
                }
                return null;
              },
              hintText: 'Mot de passe',
              controller: passwordController,
            ),
            const SizedBox(
              height: 15,
            ),
            BlocConsumer<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state is SignInFailure) {
                  myShowToastError(context, state.err);
                }
                if (state is SignInSuccess) {
                  AppRouter.navigateOff(context, AppRouter.home);
                }
              },
              builder: (context, state) {
                if (state is SignInLoading) {
                  return const Center(child: CustomLoadingIndicator());
                }
                return CustomButton(
                  title: 'Se connecter',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<SignInBloc>(context).add(
                        SignIn(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                  },
                  backgroundColor: AppColors.kPrimaryColor,
                  height: 40,
                  width: size.width * 0.32,
                );
              },
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
