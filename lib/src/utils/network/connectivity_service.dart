import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils.dart';

class ConnectivityService {
  final ProviderContainer container;

  ConnectivityService({required this.container});

  /// Vérifie la connexion à la demande via un [WidgetRef]
  Future<bool> checkWithRef(WidgetRef ref) async {
    return await ref.refresh(connectivityProvider.future);
  }

  /// Vérifie la connexion via un [ProviderContainer] global
  Future<bool> checkGlobal() async {
    return await container.read(connectivityProvider.future);
  }
}
