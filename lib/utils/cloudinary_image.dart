import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<String> uploadImageToCloudinary(XFile pickedFile, String uid) async {
  final file = File(pickedFile.path);

  final cloudName = 'dhynv8fsb';
  final uploadPreset = 'strawberry_images';

  final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = uploadPreset
    ..fields['folder'] = uid // thêm folder theo uid
    ..files.add(await http.MultipartFile.fromPath('file', file.path));

  final response = await request.send();
  final resStr = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    final data = json.decode(resStr);
    print('✅ Image uploaded to folder $uid: ${data["secure_url"]}');
    return data["secure_url"];
  } else {
    return "";
    print('❌ Upload failed: $resStr');
  }
}
