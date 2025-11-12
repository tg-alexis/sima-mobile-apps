import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../datasource/datasource.dart';
import '../../event/event_bus.dart';
import '../../utils/utils.dart';
import '../models/logout_event.dart';

/// Gestionnaire centralisé pour les événements de déconnexion
/// Ce gestionnaire écoute les LogoutEvent et effectue automatiquement :
/// - Le nettoyage des SharedPreferences
/// - La redirection vers l'écran de login
/// - Le nettoyage du cache si nécessaire
class LogoutHandler {
  static StreamSubscription? _logoutSubscription;
  static GlobalKey<NavigatorState>? _navigatorKey;

  /// Initialise le gestionnaire de logout
  /// À appeler au démarrage de l'application dans main.dart
  ///
  /// [navigatorKey] : Clé du navigateur pour gérer la navigation
  static void initialize(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;

    // Annuler l'abonnement précédent s'il existe
    _logoutSubscription?.cancel();

    // Écouter les événements LogoutEvent
    _logoutSubscription = EventBusInstance.instance.on<LogoutEvent>().listen((
      event,
    ) async {
      await _handleLogout(event);
    });

    log('LogoutHandler initialized successfully');
  }

  /// Gère le processus de déconnexion
  static Future<void> _handleLogout(LogoutEvent event) async {
    try {
      log('LogoutEvent received: ${event.reason ?? 'No reason provided'}');

      // 1. Nettoyer toutes les SharedPreferences
      await SharedPreferencesService.clearAll();
      log('SharedPreferences cleared');

      // 2. Nettoyer le cache de l'application (optionnel)
      AppExtension.clearAppCache();
      log('App cache cleared');

      // 3. Naviguer vers l'écran de login
      final context = _navigatorKey?.currentContext;
      if (context != null && context.mounted) {
        // Afficher un message à l'utilisateur si fourni
        if (event.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(event.message!),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 3),
            ),
          );
        }

        // Rediriger vers l'écran de login
        GlobalNavigationService.navigateToLogin();
        log('Navigation to LoginScreen completed');
      } else {
        log('Warning: Navigator context not available');
      }
    } catch (e) {
      log('Error during logout: $e');
    }
  }

  /// Déclenche manuellement un logout
  /// Utile pour les déconnexions volontaires (bouton logout, etc.)
  ///
  /// [reason] : Raison du logout (pour le debugging)
  /// [message] : Message à afficher à l'utilisateur
  static void triggerLogout({String? reason, String? message}) {
    EventBusInstance.instance.fire(
      LogoutEvent(reason: reason, message: message),
    );
  }

  /// Nettoie le gestionnaire
  /// À appeler lors de la fermeture de l'application
  static void dispose() {
    _logoutSubscription?.cancel();
    _logoutSubscription = null;
    _navigatorKey = null;
    log('LogoutHandler disposed');
  }
}
