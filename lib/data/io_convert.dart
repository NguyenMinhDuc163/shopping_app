import 'dart:convert';
import 'dart:io';

/// Compress JSON array into a [String] represented bytes.
String compressJsonArrayToString(List<Map<String, dynamic>> data) {
  final String input = jsonEncode(data);
  final List<int> original = utf8.encode(input); // raw bytes as utf-8 code units
  final List<int> compressed = gzip.encode(original); // GZip compressed bytes

  return compressed.toString();
}

/// Decompress a [String] represented bytes into JSON array.
List<Map<String, dynamic>> decompressToJsonArray(String compressed) {
  final List<int> input = jsonDecode(compressed);
  final List<int> decompress = gzip.decode(input); // raw bytes
  final String original = utf8.decode(decompress);
  final List<Map<String, dynamic>> data = jsonDecode(original);

  return data;
}
