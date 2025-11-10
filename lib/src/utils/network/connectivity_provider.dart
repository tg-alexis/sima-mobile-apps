import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'check_network.dart';

final connectivityProvider = FutureProvider<bool>((ref) async {
  return await checkNetwork();
});

