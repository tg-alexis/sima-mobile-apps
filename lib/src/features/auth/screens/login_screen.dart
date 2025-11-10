import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/common.dart';
import '../../../utils/utils.dart';
import '../../home/home.dart';
import '../auth.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late AuthController _authController;
  final FocusNode _emailFocus = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _authController = ref.read(authControllerProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _emailFocus.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: SizerHelper.w(6), right: SizerHelper.w(6)),
            child: Column(
              children: [
                Spacers.min,
                Assets.images.logoSima.image(width: SizerHelper.w(30)),
                Spacers.large,
                TitleText("Bienvenue", fontSize: SizerHelper.sp(20)),
                Spacers.min,
                const MediumText("Entrez vos identifiants afin d’accéder à votre compte", color: Colors.grey, textAlign: TextAlign.center),
                Spacers.medium,
                BasicInput(emailController, hintText: "Email", focusNode: _emailFocus, textInputType: TextInputType.emailAddress, nextInputForm: true),
                PasswordInput(passwordController, hintText: "Mot de passe"),
                Spacers.min,
                InkWell(child: const MediumText("Mot de passe oublié ?", textAlign: TextAlign.center)),
                Spacers.sw6,
                SubmitButton(
                  text: "Se connecter",
                  onTap: () {
                    if (checkForm()) login();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool checkForm() {
    if (emailController.text.trim().isEmpty) {
      Dialogs.displayInfoDialog(context, text: "Saisissez votre email", callback: () {});
      return false;
    }
    if (passwordController.text.trim().isEmpty) {
      Dialogs.displayInfoDialog(context, text: "Saisissez votre mot de passe", callback: () {});
      return false;
    }
    return true;
  }

  void login() async {
    Dialogs.showLoadingDialog(context);
    var response = await _authController.login(login: emailController.text.trim().toLowerCase(), password: passwordController.text.trim());
    if(!mounted) return;
    NavigationUtil.pop(context);
    if (!response) {
      Dialogs.displayInfoDialog(context, text: _authController.errorMessage ?? "La connexion a échoué.", isError: true);
      return;
    }

    NavigationUtil.pushAndRemoveUntil(context, const HomeScreen());
  }
}
