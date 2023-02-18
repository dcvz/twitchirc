import 'package:tuple/tuple.dart';

extension StringExtension on String {
  /// Splits self into two pieces by a given separator, if the separator exists in self.
  Tuple2<String, String>? splitOne(String separator) {
    final index = indexOf(separator);
    if (index == -1) {
      return null;
    }

    return Tuple2(substring(0, index), substring(index + separator.length));
  }

  /// Drops the first n characters from self.
  String dropFirst({int n = 1}) {
    // check n is not negative
    if (n < 0) {
      throw ArgumentError("n must be non-negative");
    }

    // drop as many characters as possible
    if (n >= length) {
      return "";
    }

    return substring(n);
  }

  /// Drops the last n characters from self.
  String dropLast({int n = 1}) {
    // check n is not negative
    if (n < 0) {
      throw ArgumentError("n must be non-negative");
    }

    // drop as many characters as possible
    if (n >= length) {
      return "";
    }

    return substring(0, length - n);
  }
}
