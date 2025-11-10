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
  int _page = 0;
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
      _page = 0;
      _isEndPage = false;
      _listEvents = [];
      notifyListeners();
    }

    if (_isEndPage) return;

    _page++;

    _isLoading = true;

    notifyListeners();

    var response = await _eventRepository.getEvents();

    response.when(
      failure: (String? message) {},
      onItem: (ListEventModel item) {
        // if (item.result?.isEmpty == true) {
        //   _isEndPage = true;
        //   return;
        // }
        // if (item.count == _listEvents.length) {
        //   _isEndPage = true;
        //   return;
        // }
        // if (item.result != null && item.result!.isNotEmpty) {
        //   _listEvents.addAll(item.result!);
        // }

        _listEvents = item.result ?? [];
      },
    );

    _isLoading = false;

    notifyListeners();
  }

  Future<bool> checkAccess({required String attendeeId}) async {
    bool result = false;

    _errorMessage = null;
    notifyListeners();

    if (_event == null) {
      _errorMessage = "Aucun évènement selectionné";
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
          _totalScannedPasses++;
        },
      );
    } on Exception catch (e) {
      _errorMessage = e.toString();
    }

    notifyListeners();

    return result;
  }

  void incrementScannedPasses() {
    _totalScannedPasses++;
    notifyListeners();
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

  EventModel? get event => _event;

  String? get errorMessage => _errorMessage;

  int get totalScannedPasses => _totalScannedPasses;
}
