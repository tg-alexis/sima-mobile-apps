import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sima/src/styles/colors/app_colors.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/common.dart';
import '../../../datasource/datasource.dart';
import '../../../event/event_bus.dart';
import '../../../utils/utils.dart';
import '../../auth/auth.dart';
import '../../event/event.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late AuthController _authController;
  late EventController _eventController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _authController = ref.read(authControllerProvider);
    _eventController = ref.read(eventControllerProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _eventController.getEvent();
      EventBusInstance.instance.on<LogoutEvent>().listen((event) {
        if (!mounted) return;
        _authController.logout();
        SharedPreferencesService.clearAll();
        NavigationUtil.pushAndRemoveUntil(context, const LoginScreen());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // En-tête avec logo et actions
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: SizerHelper.w(4),
                vertical: SizerHelper.w(3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.all(SizerHelper.w(2)),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(SizerHelper.w(2)),
                      ),
                      child: Icon(
                        Icons.menu,
                        color: AppColors.primaryColor,
                        size: SizerHelper.w(6),
                      ),
                    ),
                  ),
                  Assets.images.logoSima.image(width: SizerHelper.w(20)),
                  GestureDetector(
                    onTap: () => AppExtension.signOut(context),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.all(SizerHelper.w(2)),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(SizerHelper.w(2)),
                      ),
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: SizerHelper.w(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizerHelper.w(4)),
                child: Column(
                  children: [
                    Spacers.sw4,

                    // Section des statistiques
                    Consumer(
                      builder: (context, ref, child) {
                        final controller = ref.watch(eventControllerProvider);
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                AppColors.primaryColor.withValues(alpha: 0.3),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                              SizerHelper.w(4),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.3,
                                ),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(SizerHelper.w(5)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.bar_chart,
                                    color: Colors.white,
                                    size: SizerHelper.w(6),
                                  ),
                                  SizedBox(width: SizerHelper.w(2)),
                                  MediumText(
                                    "Statistiques",
                                    color: Colors.white,
                                    fontSize: SizerHelper.sp(20),
                                  ),
                                ],
                              ),
                              Spacers.sw4,
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildStatCard(
                                      icon: Icons.qr_code_scanner,
                                      title: "Pass scannés",
                                      value: controller.totalScannedPasses
                                          .toString(),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: SizerHelper.w(3)),
                                  Expanded(
                                    child: _buildStatCard(
                                      icon: Icons.event,
                                      title: "Événements",
                                      value: controller.listEvents.length
                                          .toString(),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    Spacers.sw4,

                    // Barre de recherche
                    BasicInput(
                      _searchController,
                      hintText: "Rechercher un événement...",
                      prefix: Icon(Icons.search, color: Colors.grey),
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        _eventController.searchValue = value;
                      },
                    ),

                    Spacers.sw4,

                    // Liste des événements
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, child) {
                          _eventController = ref.watch(eventControllerProvider);

                          if (_eventController.listEvents.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.event_busy,
                                    size: SizerHelper.w(20),
                                    color: Colors.grey,
                                  ),
                                  Spacers.sw4,
                                  BodyText(
                                    "Aucun événement disponible",
                                    color: Colors.grey,
                                    fontSize: SizerHelper.sp(16),
                                  ),
                                ],
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.only(bottom: SizerHelper.w(6)),
                            itemCount: _eventController.listEvents.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = _eventController.listEvents[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: SizerHelper.w(8),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      SizerHelper.w(4),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.4,
                                        ),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      SizerHelper.w(4),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // Bandeau coloré en haut
                                        Container(
                                          height: SizerHelper.w(2),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.primaryColor,
                                                AppColors.primaryColor
                                                    .withValues(alpha: 0.7),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.all(
                                            SizerHelper.w(4),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Titre de l'événement
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                      SizerHelper.w(2),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryColor
                                                          .withValues(
                                                            alpha: 0.1,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            SizerHelper.w(2),
                                                          ),
                                                    ),
                                                    child: Icon(
                                                      Icons.event,
                                                      color: AppColors
                                                          .primaryColor,
                                                      size: SizerHelper.w(5),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: SizerHelper.w(3),
                                                  ),
                                                  Expanded(
                                                    child: MediumText(
                                                      item.name ?? "",
                                                      fontSize: SizerHelper.sp(
                                                        18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Spacers.sw3,

                                              // Date
                                              if (item.date != null)
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: SizerHelper.w(2),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.calendar_today,
                                                        size: SizerHelper.w(4),
                                                        color: Colors.grey[600],
                                                      ),
                                                      SizedBox(
                                                        width: SizerHelper.w(2),
                                                      ),
                                                      BodyText(
                                                        DateFormat(
                                                          "dd/MM/yyyy",
                                                        ).format(
                                                          DateTime.parse(
                                                            item.date ?? "",
                                                          ),
                                                        ),
                                                        color: Colors.grey[600],
                                                        fontSize:
                                                            SizerHelper.sp(14),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              // Description
                                              if (item.description != null &&
                                                  item.description!
                                                      .trim()
                                                      .isNotEmpty)
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: SizerHelper.w(3),
                                                  ),
                                                  child: BodyText(
                                                    item.description ?? "",
                                                    maxLines: 2,
                                                    color: Colors.grey[700],
                                                    fontSize: SizerHelper.sp(
                                                      14,
                                                    ),
                                                  ),
                                                ),

                                              Spacers.sw3,

                                              // Bouton scanner
                                              SubmitButton(
                                                text: "Scanner un ticket",
                                                onTap: () {
                                                  _eventController.event = item;
                                                  NavigationUtil.push(
                                                    context,
                                                    const ScanScreen(),
                                                  );
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
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(SizerHelper.w(3)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(SizerHelper.w(3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: SizerHelper.w(8)),
          Spacers.sw2,
          MediumText(
            value,
            fontSize: SizerHelper.sp(24),
            color: AppColors.primaryColor,
          ),
          SizedBox(height: SizerHelper.w(1)),
          BodyText(
            title,
            fontSize: SizerHelper.sp(12),
            color: Colors.grey[600],
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
