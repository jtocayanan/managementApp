import "dart:async";
import "./managementAppEvent.dart";
import "../Data/guest.dart";

class ManagementAppBloc {
  String _view = "home";
  bool _displayNotification = false;
  bool _enableSave = false;
  List<Guest> _guestList;
  Guest _guest;

  final _displayViewStateController = StreamController<String>();
  StreamSink<String> get _inDisplayView => _displayViewStateController.sink;
  Stream<String> get displayView => _displayViewStateController.stream;

  StreamController<bool> _displayNotificationStateController =
      StreamController.broadcast();
  StreamSink<bool> get _inDisplayNotification =>
      _displayNotificationStateController.sink;
  Stream<bool> get displayNotification =>
      _displayNotificationStateController.stream;

  final _enableSaveStateController = StreamController<bool>();
  StreamSink<bool> get _inEnableSave => _enableSaveStateController.sink;
  Stream<bool> get enableSave => _enableSaveStateController.stream;

  final StreamController<List<Guest>> _getGuestListStateController =
      StreamController.broadcast();
  StreamSink<List<Guest>> get _inGetGuestList =>
      _getGuestListStateController.sink;
  Stream<List<Guest>> get getGuestList => _getGuestListStateController.stream;

  final StreamController<Guest> _addGuestStateController =
      StreamController.broadcast();
  StreamSink<Guest> get _inAddGuest => _addGuestStateController.sink;
  Stream<Guest> get addGuest => _addGuestStateController.stream;

  final _managementAppEventController = StreamController<ManagementAppEvent>();
  Sink<ManagementAppEvent> get managementAppEventSink =>
      _managementAppEventController.sink;

  ManagementAppBloc() {
    _managementAppEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ManagementAppEvent event) {
    if (event is DisplayView) {
      _view = event.data;
      _inDisplayView.add(_view);
    } else if (event is DisplayNotification) {
      _displayNotification = event.data;
      _inDisplayNotification.add(_displayNotification);
    } else if (event is GetGuestList) {
      _guestList = event.data;
      _inGetGuestList.add(_guestList);
    } else if (event is AddGuest) {
      _guest = event.data;
      _inAddGuest.add(_guest);
    } else {
      _enableSave = event.data;
      _inEnableSave.add(_enableSave);
    }
  }

  void dispose() {
    _displayViewStateController.close();
    _displayNotificationStateController.close();
    _enableSaveStateController.close();
    _getGuestListStateController.close();
    _addGuestStateController.close();
    _managementAppEventController.close();
  }
}
