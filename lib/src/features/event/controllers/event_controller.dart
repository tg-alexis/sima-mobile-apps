import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../event.dart';

final eventControllerProvider = ChangeNotifierProvider<EventController>(
  (ref) => EventController(),
);

class EventController extends ChangeNotifier {
  final EventRepositoryImpl _eventRepository = EventRepositoryImpl();
  List<EventModel> _listEvents = [];
  bool _isLoading = false;
  bool _isEndPage = false;
  bool _isScanning = false;
  EventModel? _event;
  String? _errorMessage;
  String? _searchValue;
  int _totalScannedPasses = 0;

  set event(EventModel? event) {
    _event = event;
    notifyListeners();
  }

  set searchValue(String? value) {
    _searchValue = value?.trim().isEmpty == true ? null : value;
    notifyListeners();
  }

  getEvent({bool newSearch = false}) async {
    if (newSearch) {
      _isEndPage = false;
      _listEvents = [];
      notifyListeners();
    }

    if (_isEndPage) return;

    _isLoading = true;

    notifyListeners();

    var response = await _eventRepository.getEvents();
    response.when(
      failure: (String? message) {},
      onItem: (ListEventModel item) {
        _listEvents = item.result ?? [];
      },
    );

    _isLoading = false;

    notifyListeners();
  }

  Future<bool> checkAccess({required String attendeeId}) async {
    bool result = false;

    _isScanning = true;
    _errorMessage = null;
    notifyListeners();

    if (_event == null) {
      _errorMessage = "Aucun évènement selectionné";
      _isScanning = false;
      notifyListeners();
      return false;
    }

    try {
      var response = await _eventRepository.checkAccess(
        eventId: _event!.id!,
        attendeeId: attendeeId,
      );

      response.when(
        failure: (String? message) {
          _errorMessage = message;
        },
        onItem: (AttendeeModel item) {
          result = true;
        },
      );
    } on Exception catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isScanning = false;
    }

    notifyListeners();

    return result;
  }

  getStatistics() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var response = await _eventRepository.getStatistics();
      response.when(
        failure: (String? message) {
          _errorMessage = message;
        },
        onItem: (StatisticsModel item) {
          _totalScannedPasses = item.totalAccess ?? 0;
        },
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Méthode pour rafraîchir toutes les données
  Future<void> refreshData() async {
    // Ne pas rafraîchir si un scan est en cours
    if (_isScanning || _isLoading) {
      return;
    }

    _searchValue = null;
    await getStatistics();
    await getEvent(newSearch: true);
  }

  List<EventModel> get listEvents => _searchValue == null
      ? _listEvents
      : _listEvents
            .where(
              (element) => element.name!.toLowerCase().contains(
                _searchValue!.toLowerCase(),
              ),
            )
            .toList();

  bool get isLoading => _isLoading;

  bool get isScanning => _isScanning;

  EventModel? get event => _event;

  int get totalScannedPasses => _totalScannedPasses;

  String? get errorMessage => _errorMessage;
}
