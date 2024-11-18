
import 'dart:convert';
import 'dart:typed_data';
// Function to encode data into TLV format
Uint8List encodeTLVData(List<List<String>> fields) {
  final bytes = BytesBuilder();
  for (var field in fields) {
    final tag = int.parse(field[0]);
    final value = field[1];
    bytes.add([tag]);
    bytes.add([value.length]);
    bytes.add(utf8.encode(value));
  }
  return bytes.toBytes();
}