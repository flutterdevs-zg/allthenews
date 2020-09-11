extension DateTimeFormatter on DateTime {
  String formatDate() => "$year-$month-$day";

  String formatTime() => "$hour:$minute:$second";
}
