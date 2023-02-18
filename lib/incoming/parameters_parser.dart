import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';

import '../extensions/string.dart';

/// Parses parameters from Twitch-sent values.
class ParametersParser {
  /// The storage of the values.
  late Map<int, Tuple2<String, String>> storage;
  /// Indices of the used storage elements.
  Set<int> usedIndices = {};
  /// Keys that were unavailable.
  List<String>unavailableKeys = [];

  ParametersParser(String input) {
    final values = input
      .split(";")
      .map((e) =>
        e.splitOne("=") == null ? null : Tuple2(e.splitOne("=")!.item1, e.splitOne("=")!.item2)
      )
      .whereType<Tuple2<String, String>>()
      .toList();

      // save to storage, with index
      storage = values.asMap();
  }

  MapEntry<int, Tuple2<String, String>>? get(String key) {
    final stored = storage.entries.firstWhereOrNull((element) => element.value.item1 == key);
    if (stored != null) {
      usedIndices.add(stored.key);
      return stored;
    } else {
      unavailableKeys.add(key);
      return null;
    }
  }

  String? stringOrNull(String key) {
    final stored = get(key);
    if (stored != null) {
      return stored.value.item2;
    } else {
      return null;
    }
  }

  String string(String key) {
    final value = stringOrNull(key);
    return value ?? "";
  }

  bool? booleanOrNull(String key) {
    final value = stringOrNull(key);
    if (value != null) {
      if (value == "1" || value == "true") {
        return true;
      } else if (value == "0" || value == "false") {
        return false;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  bool boolean(String key) {
    final value = booleanOrNull(key);
    return value ?? false;
  }

  int? integerOrNull(String key) {
    final value = stringOrNull(key);
    if (value != null) {
      return int.tryParse(value);
    } else {
      return null;
    }
  }

  int integer(String key) {
    final value = integerOrNull(key);
    return value ?? 0;
  }

  List<String> array(String key) {
    final value = stringOrNull(key);
    if (value != null) {
      return value.split(",").where((element) => element.isNotEmpty).toList();
    } else {
      return [];
    }
  }
}

// whereType<>()