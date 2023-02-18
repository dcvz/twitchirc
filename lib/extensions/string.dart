
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
}