String formatDateTimeToDateString(DateTime dateTime) =>
    "${dateTime.year}-{${dateTime.month}-${dateTime.day}";

String formatDateTimeToTimeString(DateTime dateTime) =>
    "${dateTime.hour}:{${dateTime.minute}:${dateTime.second}";
