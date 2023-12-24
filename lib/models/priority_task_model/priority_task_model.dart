class PriorityTaskModel {
  String name;
  int id;
  String description;
  DateTime deadline;

  PriorityTaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.deadline,
  });

  // Convert PriorityTaskModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'deadline': deadline.toIso8601String(),
    };
  }

  // Create PriorityTaskModel from JSON
  factory PriorityTaskModel.fromJson(Map<String, dynamic> json) {
    return PriorityTaskModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
    );
  }

  // Implement comparison based on the deadline field
  int compareTo(PriorityTaskModel other) {
    return deadline.compareTo(other.deadline);
  }
}