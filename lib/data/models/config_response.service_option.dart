// class ServiceOption {
//   final int value;
//   final String name;
//
//   ServiceOption({required this.value, required this.name});
//
//   factory ServiceOption.fromMap(Map<String, dynamic> map) {
//     return ServiceOption(
//       value: map['value'],
//       name: map['name'],
//     );
//   }
//
// // equal
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ServiceOption &&
//           runtimeType == other.runtimeType &&
//           value == other.value &&
//           name == other.name;
//
//   @override
//   int get hashCode => value.hashCode ^ name.hashCode;
// }
