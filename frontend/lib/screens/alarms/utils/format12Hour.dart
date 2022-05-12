Format12Hour(hour, minute) {
  String _type = "AM";
  if (hour >= 12) {
    _type = "PM";
  }
  if (hour == 24) {
    _type = "AM";
  }
  if (hour > 12) {
    hour -= 12;
  }
  if (hour == 0) {
    hour = 12;
  }
  return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $_type";
}
