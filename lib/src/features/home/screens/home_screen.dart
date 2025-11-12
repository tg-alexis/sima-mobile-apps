import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sima/src/styles/colors/app_colors.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/common.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _refreshTimer;

  @override
  void initState() {
    _authController = ref.read(authControllerProvider);
    _eventController = ref.read(eventControllerProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadInitialData();
      _startAutoRefresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  /// Charge les données initiales
  void _loadInitialData() {
    _eventController.getEvent();
    _eventController.getStatistics();
  }

  /// Démarre le rafraîchissement automatique toutes les 5 minutes
  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      // Ne rafraîchir que si l'écran est visible et monté
      if (mounted && ModalRoute.of(context)?.isCurrent == true) {
        _eventController.refreshData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: Consumer(
        builder: (context, ref, child) {
          _authController = ref.watch(authControllerProvider);
          if (_authController.user?.isAdmin == false) return Container();

          return Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  Spacers.min,
                  Assets.images.logoSima.image(width: SizerHelper.w(20)),
                  Spacers.medium,
                  GestureDetector(
                    onTap: () {
                      NavigationUtil.pop(context);
                      NavigationUtil.push(context, const ListUserScreen());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(SizerHelper.w(4)),
                      child: Container(
                        padding: EdgeInsets.all(SizerHelper.w(2)),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(SizerHelper.w(3)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                              size: SizerHelper.w(6),
                            ),
                            Spacers.min,
                            MediumText(
                              "Liste des utilisateurs",
                              color: AppColors.primaryColor,
                              fontSize: SizerHelper.sp(15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
                  Consumer(
                    builder: (context, ref, child) {
                      _authController = ref.watch(authControllerProvider);
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (_authController.user?.isAdmin == true) {
                            _scaffoldKey.currentState?.openDrawer();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(SizerHelper.w(2)),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(
                              SizerHelper.w(2),
                            ),
                          ),
                          child: Icon(
                            _authController.user?.isAdmin == true
                                ? Icons.menu
                                : Icons.home,
                            color: AppColors.primaryColor,
                            size: SizerHelper.w(6),
                          ),
                        ),
                      );
                    },
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
                                  Expanded(
                                    child: MediumText(
                                      "Statistiques",
                                      color: Colors.white,
                                      fontSize: SizerHelper.sp(20),
                                    ),
                                  ),
                                  // Bouton refresh
                                  GestureDetector(
                                    onTap: () async {
                                      Dialogs.showLoadingDialog(
                                        context,
                                        message: "Actualisation...",
                                      );
                                      await controller.refreshData();
                                      if (!context.mounted) return;
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(SizerHelper.w(2)),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          SizerHelper.w(2),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                        size: SizerHelper.w(5),
                                      ),
                                    ),
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
                                  bottom: SizerHelper.w(4),
                                  left: SizerHelper.w(2),
                                  right: SizerHelper.w(2),
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
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Spacers.sw3,

                                              // Section infos : Date et Stats
                                              Row(
                                                children: [
                                                  // Date
                                                  if (item.date != null)
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today,
                                                            size: SizerHelper.w(
                                                              4,
                                                            ),
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                SizerHelper.w(
                                                                  2,
                                                                ),
                                                          ),
                                                          Expanded(
                                                            child: BodyText(
                                                              DateFormat(
                                                                "dd/MM/yyyy",
                                                              ).format(
                                                                DateTime.parse(
                                                                  item.date ??
                                                                      "",
                                                                ),
                                                              ),
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize:
                                                                  SizerHelper.sp(
                                                                    13,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  // Séparateur vertical si date existe
                                                  if (item.date != null &&
                                                      item.totalAccess != null)
                                                    Container(
                                                      height: SizerHelper.w(6),
                                                      width: 1,
                                                      color: Colors.grey[300],
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                SizerHelper.w(
                                                                  3,
                                                                ),
                                                          ),
                                                    ),

                                                  // Statistique de scans
                                                  if (item.totalAccess != null)
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                SizerHelper.w(
                                                                  2.5,
                                                                ),
                                                            vertical:
                                                                SizerHelper.w(
                                                                  1.5,
                                                                ),
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
                                                        border: Border.all(
                                                          color: AppColors
                                                              .primaryColor
                                                              .withValues(
                                                                alpha: 0.3,
                                                              ),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .qr_code_scanner,
                                                            color: AppColors
                                                                .primaryColor,
                                                            size: SizerHelper.w(
                                                              4,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                SizerHelper.w(
                                                                  1.5,
                                                                ),
                                                          ),
                                                          MediumText(
                                                            _formatNumber(
                                                              item.totalAccess ??
                                                                  0,
                                                            ),
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontSize:
                                                                SizerHelper.sp(
                                                                  14,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
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
                                                onTap: () async {
                                                  _eventController.event = item;
                                                  await NavigationUtil.push(
                                                    context,
                                                    const ScanScreen(),
                                                  );
                                                  // Rafraîchir les données après le retour du scan
                                                  if (mounted) {
                                                    _eventController
                                                        .refreshData();
                                                  }
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

  // Fonction pour formater les grands nombres
  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}
