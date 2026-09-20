class MechanicLogParam {
  final String setupId;
  final String mechanicName;
  final String note;

  MechanicLogParam({
    required this.setupId,
    required this.mechanicName,
    required this.note,
  });

  // Mengubah Object menjadi Map untuk dikirim via Dio FormData
  Map<String, dynamic> toJson() => {
    "setup_id": setupId,
    "mechanic_name": mechanicName,
    "note": note,
  };
}