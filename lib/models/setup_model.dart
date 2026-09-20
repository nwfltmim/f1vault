class SetupModel {
  final String id;
  final String circuitName;

  SetupModel({required this.id, required this.circuitName});

  factory SetupModel.fromJson(Map<String, dynamic> json) {
    return SetupModel(
      id: json['id'].toString(),
      circuitName: json['circuit_name'] ?? 'Unknown Circuit',
    );
  }
}