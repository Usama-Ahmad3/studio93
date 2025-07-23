import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GeminiResponseModelEntity extends Equatable {
  final String? time;
  final String? date;
  final String title;
  final DateTime? createdAt;
  final DateTime? lastEdited;
  final String description;
  final String? id;
  const GeminiResponseModelEntity({
    this.time,
    this.title = '',
    this.date,
    this.lastEdited,
    this.createdAt,
    this.description = '',
    this.id,
  });
  const GeminiResponseModelEntity.empty()
    : title =
          "Can't Get Any Thing From Given Speech!\nPlease Provide Clear Speech",
      date = '',
      createdAt = null,
      lastEdited = null,
      time = '',
      id = '',
      description = '';
  GeminiResponseModelEntity copyWith({
    String? title,
    String? time,
    String? date,
    String? description,
    DateTime? createdAt,
    String? id,
    DateTime? lastEdited,
  }) {
    return GeminiResponseModelEntity(
      description: description ?? this.description,
      title: title ?? this.title,
      time: time ?? this.time,
      date: date ?? this.date,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      lastEdited: lastEdited ?? this.lastEdited,
    );
  }

  factory GeminiResponseModelEntity.fromDocument(DocumentSnapshot map) {
    final data = map.data() as Map<String, dynamic>;
    return GeminiResponseModelEntity(
      id: map.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      lastEdited:
          (data['lastEdited'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "title": title,
      "time": time,
      "date": date,
      "createdAt": Timestamp.fromDate(createdAt ?? DateTime.now()),
      "lastEdited": Timestamp.fromDate(lastEdited ?? DateTime.now()),
    };
  }

  @override
  List<Object?> get props => [
    title,
    time,
    date,
    id,
    description,
    createdAt,
    lastEdited,
  ];
}
