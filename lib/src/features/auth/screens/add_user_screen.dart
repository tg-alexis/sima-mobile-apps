import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/common.dart';
import '../../../utils/utils.dart';
import '../auth.dart';

class AddUserScreen extends ConsumerStatefulWidget {
  const AddUserScreen({super.key});

  @override
  ConsumerState<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late AuthController _authController;
  Profile? _profile;
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();

  @override
  void initState() {
    _authController = ref.read(authControllerProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizerHelper.w(4)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Spacers.medium,
                Stack(
                  children: [
                    Positioned(left: 0, right: 0, child: Assets.images.logoSima.image(height: SizerHelper.w(12))),
                    Row(
                      children: [BackIconWidget(icon: Icons.arrow_back, iconColor: Colors.white)],
                    ),
                  ],
                ),
                Spacers.large,
                TitleText("Ajout d'un utilisateur", fontSize: 22),
                Spacers.large,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BasicInput(_lastNameController, hintText: "Nom", text: "Nom"),
                      BasicInput(_firstNameController, hintText: "Prénoms", text: "Prénoms"),
                      BasicInput(_emailController, hintText: "Email", text: "Email", textInputType: TextInputType.emailAddress),
                      BasicInput(_phoneController, hintText: "Numéro de téléphone", text: "Numéro de téléphone", textInputType: TextInputType.phone),
                      BasicInput(_profileController, hintText: "Profil", text: "Profil", readOnly: true, onTap: () => showProfileModals()),
                    ],
                  ),
                ),
                Spacers.medium,
                SubmitButton(
                  text: "Ajouter",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      confirmAddUser();
                    }
                  },
                ),
                Spacers.large,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void confirmAddUser() {
    Dialogs.displayActionDialog(
      context,
      callback: () {
        addUser();
      },
      sideCallback: () {
        Navigator.pop(context);
      },
      title: "Confirmer l'ajout\nVous êtes sur le point d'ajouter d'un utlisateur",
    );
  }

  void addUser() async {
    Dialogs.showLoadingDialog(context);
    try {
      var response = await _authController.createUser(
        UserModel(
          firstname: _firstNameController.text.trim(),
          lastname: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: "+225${_phoneController.text.trim().replaceAll("+225", "")}",
          profileId: _profile?.id,
        ),
      );

      if (!mounted) return;

      NavigationUtil.pop(context);

      if (!response) {
        Dialogs.displayInfoDialog(context, text: _authController.errorMessage ?? "L'ajout a échoué", isError: true);
        return;
      }

      Dialogs.displayInfoDialog(
        context,
        text: "L'utilisateur a été ajouté avec succès",
        callback: () {
          NavigationUtil.pop(context);
        },
      );
    } catch (e) {
      NavigationUtil.pop(context);

      Dialogs.displayInfoDialog(context, text: e.toString(), isError: true);
    }
  }

  void showProfileModals() {
    Modals.showBottomModal(
      context,
      child: ListView.builder(
        itemCount: _authController.profiles.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var item = _authController.profiles[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                _profile = item;
                _profileController.text = item.name ?? "";
              });
              Navigator.pop(context);
            },
            child: Padding(padding: EdgeInsets.all(SizerHelper.w(2)), child: MediumText(item.name ?? "")),
          );
        },
      ),
    );
  }
}
