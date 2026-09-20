import 'package:dio/dio.dart';
import '../models/setup_model.dart';
import '../params/mechanic_log_param.dart';
import '../response/setup_response.dart';

class ApiRepository {
  // PENTING: Gunakan 10.0.2.2 untuk emulator
  final String baseUrl = "http://10.0.2.2/f1_api";

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    responseType: ResponseType.json,
  ));

  // [MENU 1] Search Data (Mengembalikan SetupResponse)
  Future<SetupResponse> searchData(String keyword) async {
    try {
      final response = await _dio.get(
          "$baseUrl/search.php",
          queryParameters: {'search': keyword}
      );
      return SetupResponse.fromJson(response.data);
    } catch (e) {
      // Kembalikan list kosong jika error/data tidak ditemukan
      return SetupResponse(data: [], status: "Error: $e");
    }
  }

  // [MENU 2] Post Data Log (Mengirim MechanicLogParam)
  Future<bool> postLog(MechanicLogParam param) async {
    try {
      final response = await _dio.post(
          "$baseUrl/create_log.php",
          data: FormData.fromMap(param.toJson())
      );

      if (response.statusCode == 200) {
        final data = response.data;
        // Cek jika server merespon status success
        if (data is Map && data['status'] == 'success') {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // [PENDUKUNG] Get Dropdown List
  Future<List<SetupModel>> getDropdownList() async {
    try {
      final response = await _dio.get("$baseUrl/read.php");
      // Konversi data JSON array langsung ke List<SetupModel>
      return (response.data as List)
          .map((e) => SetupModel.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }
}