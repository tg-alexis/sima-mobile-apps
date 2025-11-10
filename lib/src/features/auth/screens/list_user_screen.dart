import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/common.dart';
import '../../../styles/colors/colors.dart';
import '../../../utils/utils.dart';
import '../auth.dart';

class ListUserScreen extends ConsumerStatefulWidget {
  const ListUserScreen({super.key});

  @override
  ConsumerState<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends ConsumerState<ListUserScreen> {
  late AuthController _authController;

  @override
  void initState() {
    _authController = ref.read(authControllerProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authController.getProfiles();
      _authController.getUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: BackIconWidget(
        iconWidget: Padding(
          padding: EdgeInsets.all(SizerHelper.w(2)),
          child: Icon(Icons.add, color: Colors.white),
        ),
        onTap: () => NavigationUtil.push(context, const AddUserScreen()),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizerHelper.w(4)),
          child: RefreshIndicator(
            onRefresh: () async {
              _authController.getProfiles();
              _authController.getUsers();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                  TitleText("Liste des utilisateurs", fontSize: 22),
                  Spacers.medium,
                  Consumer(
                    builder: (context, ref, child) {
                      _authController = ref.watch(authControllerProvider);
                        
                      return ListView.builder(
                        itemCount: _authController.users.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var item = _authController.users[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: SizerHelper.w(4), left: SizerHelper.w(2), right: SizerHelper.w(2)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(SizerHelper.w(4)),
                                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.4), spreadRadius: 0, blurRadius: 1, offset: Offset(0, 2))],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(SizerHelper.w(4)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Bandeau coloré en haut
                                    Container(
                                      height: SizerHelper.w(2),
                                      decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primaryColor, AppColors.primaryColor.withValues(alpha: 0.7)])),
                                    ),
                        
                                    Padding(
                                      padding: EdgeInsets.all(SizerHelper.w(4)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              BodyText("Nom : "),
                                              Expanded(child: MediumText(item.lastname ?? "")),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              BodyText("Prenoms : "),
                                              Expanded(child: MediumText(item.firstname ?? "")),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              BodyText("Numéro : "),
                                              Expanded(child: MediumText(item.phone ?? "")),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              BodyText("Profil : "),
                                              Expanded(child: MediumText(item.profile?.name ?? "")),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
