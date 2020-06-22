import '../Data/guest.dart';

abstract class ManagementAppEvent {
  var data;
}

class DisplayView extends ManagementAppEvent {
  final String data;
  DisplayView(this.data);
}

class DisplayNotification extends ManagementAppEvent {
  final bool data;
  DisplayNotification(this.data);
}

class EnableSave extends ManagementAppEvent {
  final bool data;
  EnableSave(this.data);
}

class GetGuestList extends ManagementAppEvent {
  final List<Guest> data;
  GetGuestList(this.data);
}

class AddGuest extends ManagementAppEvent {
  final Guest data;
  AddGuest(this.data);
}
