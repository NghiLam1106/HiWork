import 'package:dio/dio.dart';

class CloudinaryRemoteDataSource {
  final Dio dio;

  CloudinaryRemoteDataSource(this.dio);

  Future<String> uploadFaceImage(String imagePath) async {
    const cloudName = "dpjpqdp71";
    const uploadPreset = "ml_default";

    final url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    final form = FormData.fromMap({
      "upload_preset": uploadPreset,
      "file": await MultipartFile.fromFile(imagePath, filename: "face.jpg"),
    });

    final res = await dio.post(url, data: form);

    final data = res.data as Map<String, dynamic>;
    final secureUrl = data["secure_url"] as String?;
    if (secureUrl == null || secureUrl.isEmpty) {
      throw Exception("Upload Cloudinary failed: missing secure_url");
    }
    return secureUrl;
  }
}
