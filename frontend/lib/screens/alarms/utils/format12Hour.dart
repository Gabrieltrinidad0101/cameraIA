Format12Hour(hour, minute) {
  String _type = "AM";
  int minus = 0;
  if (hour >= 12) {
    _type = "PM";
  }
  if (hour == 24) {
    _type = "AM";
  }
  if (hour > 12) {
    minus = 12;
  }
  if (hour == 0) {
    hour = 12;
  }

  return "${hour - minus}:$minute $_type";
}
