import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/common.dart';
import 'connectivity_provider.dart';

class ConnectivityListener extends ConsumerWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(connectivityProvider, (previous, next) {
      next.whenData((isConnected) {
        final messenger = ScaffoldMessenger.of(context);
        if (isConnected == false) {
          ScaffoldMessenger.of(context).clearSnackBars();
          messenger.showSnackBar(
            SnackBar(
              content: MediumText("Pas de connexion internet", color: Colors.white,),
              duration: const Duration(days: 1),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      });
    });

    return child;
  }
}
