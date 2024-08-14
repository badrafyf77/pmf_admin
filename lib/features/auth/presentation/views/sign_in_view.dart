import 'package:pmf_admin/core/utils/customs/custom_scaffold.dart';
import 'package:pmf_admin/features/auth/presentation/views/widgets/login_json_animation.dart';
import 'package:pmf_admin/features/auth/presentation/views/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Row(
        children: [
          LoginJsonAnimation(),
          SignInForm(),
        ],
      ),
    );
  }
}
