import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/common.dart';
import '../../../styles/colors/colors.dart';
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
  final FocusNode _passwordFocus = FocusNode();
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
      body: BackgroundScreen(
        useSafeArea: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Spacers.sw20,
              // Logo SIMA
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.logoSima.image(width: SizerHelper.w(35)),
                ],
              ),
              Spacers.sw8,
              TitleText("BIENVENUE", fontSize: SizerHelper.sp(25)),
              Spacers.sw3,
              // Sous-titre
              BodyText(
                "Entrez vos identifiants afin d’accéder\nà votre compte",
                textAlign: TextAlign.center,
                fontSize: SizerHelper.sp(16),
                color: AppColors.darkerGrayColor,
              ),
              Spacers.sw10,
              // Champ Email
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizerHelper.w(5),
                  vertical: SizerHelper.w(1),
                ),
                child: Column(
                  children: [
                    BasicInput(
                      emailController,
                      hintText: "Email",
                      focusNode: _emailFocus,
                      textInputType: TextInputType.emailAddress,
                      nextInputForm: true,
                    ),
                    Spacers.sw2,
                    PasswordInput(
                      passwordController,
                      hintText: "Mot de passe",
                      focusNode: _passwordFocus,
                    ),
                    Spacers.sw2,
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          // Action mot de passe oublié
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizerHelper.w(1),
                          ),
                          child: MediumText(
                            "Mot de passe oublié?",
                            color: AppColors.primaryColor,
                            fontSize: SizerHelper.sp(13),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Spacers.sw5,
                    SubmitButton(
                      text: "Se connecter",
                      onTap: () {
                        if (checkForm()) login();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkForm() {
    if (emailController.text.trim().isEmpty) {
      Dialogs.displayInfoDialog(
        context,
        text: "Saisissez votre email",
        callback: () {},
      );
      return false;
    }
    if (passwordController.text.trim().isEmpty) {
      Dialogs.displayInfoDialog(
        context,
        text: "Saisissez votre mot de passe",
        callback: () {},
      );
      return false;
    }
    return true;
  }

  void login() async {
    Dialogs.showLoadingDialog(context);
    var response = await _authController.login(
      login: emailController.text.trim().toLowerCase(),
      password: passwordController.text.trim(),
    );
    if (!mounted) return;
    NavigationUtil.pop(context);
    if (!response) {
      Dialogs.displayInfoDialog(
        context,
        text: _authController.errorMessage ?? "La connexion a échoué.",
        isError: true,
      );
      return;
    }

    NavigationUtil.pushAndRemoveUntil(context, const HomeScreen());
  }
}
