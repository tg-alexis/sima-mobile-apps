import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizerHelper.w(4)),
        child: Column(
          children: [
            Spacers.sw8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(SizerHelper.w(2)),
                    child: Icon(Icons.menu, color: Colors.blue),
                  ),
                ),
                Assets.images.logoSima.image(width: SizerHelper.w(20)),
                GestureDetector(
                  onTap: () => AppExtension.signOut(context),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(SizerHelper.w(2)),
                    child: Icon(Icons.logout, color: Colors.blue),
                  ),
                ),
              ],
            ),
            Spacers.sw8,
            BasicInput(
              _searchController,
              hintText: "Rechercher un évent...",
              prefix: Icon(Icons.search, color: Colors.grey),
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) {
                _eventController.searchValue = value;
              },
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Consumer(
                  builder: (context, ref, child) {
                    _eventController = ref.watch(eventControllerProvider);

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _eventController.listEvents.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = _eventController.listEvents[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: SizerHelper.w(4), left: SizerHelper.w(2), right: SizerHelper.w(2)),
                          child: Container(
                            padding: EdgeInsets.all(SizerHelper.w(4)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(SizerHelper.w(4)),
                              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                              boxShadow: [BoxShadow(color: Colors.blue.withValues(alpha: 0.2), spreadRadius: 1, blurRadius: 2, offset: Offset(0, 3))],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MediumText(item.name ?? "", textAlign: TextAlign.center),
                                Spacers.sw4,
                                Visibility(
                                  visible: item.date != null,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      BodyText("Description: ", fontSize: SizerHelper.sp(15), color: Colors.grey),
                                      BodyText(DateFormat("dd/MM/yyyy").format(DateTime.parse(item.date ?? ""))),
                                      Spacers.min,
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: item.description != null && item.description!.trim().isNotEmpty,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      BodyText("Description: ", fontSize: SizerHelper.sp(15), color: Colors.grey),
                                      BodyText(item.description ?? "", maxLines: 3),
                                      Spacers.min,
                                    ],
                                  ),
                                ),
                                Divider(endIndent: SizerHelper.w(4), indent: SizerHelper.w(4)),
                                Spacers.min,
                                SubmitButton(
                                  text: "Scanner un ticket",
                                  onTap: () {
                                    _eventController.event = item;
                                    NavigationUtil.push(context, const ScanScreen());
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
