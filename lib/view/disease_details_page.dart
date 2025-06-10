import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/common/widget/confidence_icon.dart';
import 'package:strawberry_disease_detection/model/plant.dart';
import 'package:strawberry_disease_detection/constant/size.dart';

class DiseaseDetailsPage extends StatelessWidget{
  const DiseaseDetailsPage({super.key});


  @override
  Widget build(BuildContext context) {
    final plant = ModalRoute.of(context)?.settings.arguments;
    final Plant plantArg = ModalRoute.of(context)?.settings.arguments as Plant;
    final String imagePath = plantArg.imageUrl ?? '';
    final List<dynamic> predictions = plantArg.diseases?['predictions'] ?? {};
    final image = plantArg.diseases?['image'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả phát hiện bệnh'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSize.defaultSpace / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị hình ảnh với các bounding boxes
            SizedBox(
              width: double.infinity,
              height: 400,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      // Hình ảnh
                      Image.network(
                        imagePath, // Đường dẫn URL ảnh
                        width: constraints.maxWidth,
                        height: 400,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text(
                              'Không thể tải hình ảnh. Vui lòng kiểm tra đường dẫn.',
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      // Vẽ các bounding boxes
                      ...predictions
                          .asMap()
                          .entries
                          .map((entry) {
                        final prediction = entry.value;
                        return CustomPaint(
                          painter: BoundingBoxPainter(
                            x: prediction['x'].toDouble(),
                            y: prediction['y'].toDouble(),
                            width: prediction['width'].toDouble(),
                            height: prediction['height'].toDouble(),
                            className: prediction['class'],
                            confidence: prediction['confidence'].toDouble(),
                            containerWidth: constraints.maxWidth,
                            containerHeight: 400,
                            // Kích thước gốc của ảnh
                            originalImageWidth: image['width']?.toDouble() ?? 512,
                            originalImageHeight: image['height']?.toDouble() ?? 512,
                          ),
                          child: Container(
                            width: constraints.maxWidth,
                            height: 400,
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Hiển thị thông tin chi tiết
            ...predictions
                .asMap()
                .entries
                .map((entry) {
              final index = entry.key;
              final prediction = entry.value;
              return InkWell(
                onTap: (){

                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Disease ${index + 1}:',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        '🦠 Loại bệnh: ${prediction['class']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        '${getEmoji(prediction['confidence'])} '
                            'Độ tin cậy: ${(prediction['confidence'] * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                
                ),
              );
            }).toList(),
            if (predictions.isEmpty)
              const Text(
                'Không có dữ liệu phát hiện bệnh.',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

class BoundingBoxPainter extends CustomPainter {
  final double x;
  final double y;
  final double width;
  final double height;
  final String className;
  final double confidence;
  final double containerWidth;
  final double containerHeight;
  final double originalImageWidth;
  final double originalImageHeight;

  BoundingBoxPainter({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.className,
    required this.confidence,
    required this.containerWidth,
    required this.containerHeight,
    required this.originalImageWidth,
    required this.originalImageHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Tính tỷ lệ và vị trí thực tế của ảnh trong container
    final double imageAspectRatio = originalImageWidth / originalImageHeight;
    final double containerAspectRatio = containerWidth / containerHeight;

    double scale;
    double offsetX = 0;
    double offsetY = 0;
    double scaledImageWidth;
    double scaledImageHeight;

    // Tính toán tỷ lệ và vị trí dựa trên BoxFit.contain
    if (imageAspectRatio > containerAspectRatio) {
      // Ảnh rộng hơn container -> điều chỉnh theo chiều rộng
      scale = containerWidth / originalImageWidth;
      scaledImageWidth = containerWidth;
      scaledImageHeight = originalImageHeight * scale;
      offsetY = (containerHeight - scaledImageHeight) / 2;
    } else {
      // Ảnh cao hơn container -> điều chỉnh theo chiều cao
      scale = containerHeight / originalImageHeight;
      scaledImageHeight = containerHeight;
      scaledImageWidth = originalImageWidth * scale;
      offsetX = (containerWidth - scaledImageWidth) / 2;
    }

    // Tính toán tọa độ và kích thước bounding box
    final double left = offsetX + (x - width / 2) * scale;
    final double top = offsetY + (y - height / 2) * scale;
    final double right = offsetX + (x + width / 2) * scale;
    final double bottom = offsetY + (y + height / 2) * scale;

    // Vẽ hình chữ nhật
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRect(
      Rect.fromLTRB(left, top, right, bottom),
      paint,
    );

    // Thêm nhãn với thông tin class và confidence
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$className ${(confidence * 100).toStringAsFixed(0)}%',
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          backgroundColor: Colors.white70,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(left, top - 15));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

