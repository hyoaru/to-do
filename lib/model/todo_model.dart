// import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

class TodoObjectModel {
  TodoObjectModel({
    required this.description,
    this.isCompleted = false,
    String? id,
  }) : id = id ?? _uuid.v4();

  final String id;
  final String description;
  final bool isCompleted;

  @override
  String toString() {
    return 'TodoObjectModel(description: $description, isCompleted: $isCompleted)';
  }
}
