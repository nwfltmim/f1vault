import '../models/setup_model.dart';

class SetupResponse {
  final List<SetupModel> data;
  final String status;

  SetupResponse({required this.data, required this.status});

  factory SetupResponse.fromJson(List<dynamic> json) {
    return SetupResponse(
      // Mapping list JSON menjadi List<SetupModel>
      data: json.map((i) => SetupModel.fromJson(i)).toList(),
      status: "Success",
    );
  }
}