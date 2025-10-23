import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class ImgbbRemoteDataSource {
  /// Uploads [imageFile] to imgbb and returns the image URL on success.
  /// Throws an Exception on failure.
  Future<String> uploadImage(File imageFile);
}

class ImgbbRemoteDataSourceImpl implements ImgbbRemoteDataSource {
  final String apiKey;
  final http.Client client;

  ImgbbRemoteDataSourceImpl({required this.apiKey, http.Client? client})
    : client = client ?? http.Client();

  @override
  Future<String> uploadImage(File imageFile) async {
    final uri = Uri.parse('https://api.imgbb.com/1/upload');

    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await client.post(
      uri,
      body: {'key': apiKey, 'image': base64Image},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final data = json['data'] as Map<String, dynamic>;
      final url = data['url'] as String?;
      if (url != null && url.isNotEmpty) {
        return url;
      }
      throw Exception('imgbb: invalid response, missing url');
    } else {
      throw Exception(
        'imgbb upload failed: ${response.statusCode} ${response.body}',
      );
    }
  }
}
