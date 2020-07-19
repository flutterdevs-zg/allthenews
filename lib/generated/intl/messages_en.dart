// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutApp" : MessageLookupByLibrary.simpleMessage("About"),
    "apiConnectionException" : MessageLookupByLibrary.simpleMessage("No internet connection"),
    "apiInvalidUrlException" : MessageLookupByLibrary.simpleMessage("Resource not found"),
    "apiServerException" : MessageLookupByLibrary.simpleMessage("Internal server error"),
    "apiUnauthorizedException" : MessageLookupByLibrary.simpleMessage("Authorization error"),
    "apiUnknownException" : MessageLookupByLibrary.simpleMessage("Unknown error"),
    "darkMode" : MessageLookupByLibrary.simpleMessage("Dark mode"),
    "emailed" : MessageLookupByLibrary.simpleMessage("E-mailed"),
    "mostViewed" : MessageLookupByLibrary.simpleMessage("Most Viewed"),
    "newest" : MessageLookupByLibrary.simpleMessage("Newest"),
    "popular" : MessageLookupByLibrary.simpleMessage("Popular"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "shared" : MessageLookupByLibrary.simpleMessage("Shared"),
    "showAll" : MessageLookupByLibrary.simpleMessage("Show All"),
    "version" : MessageLookupByLibrary.simpleMessage("Version"),
    "viewed" : MessageLookupByLibrary.simpleMessage("Viewed")
  };
}
