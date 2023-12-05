class ApiResponse {
  final double time;
  final ImageInfo image;
  final List<Prediction> predictions;

  ApiResponse({
    required this.time,
    required this.image,
    required this.predictions,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      time: json['time'].toDouble(),
      image: ImageInfo.fromJson(json['image']),
      predictions: (json['predictions'] as List<dynamic>)
          .map((prediction) => Prediction.fromJson(prediction))
          .toList(),
    );
  }
}

class ImageInfo {
  final int width;
  final int height;

  ImageInfo({required this.width, required this.height});

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      width: json['width'],
      height: json['height'],
    );
  }
}

class Prediction {
  final double x;
  final double y;
  final double width;
  final double height;
  final double confidence;
  final String classLabel;
  final int classId;

  Prediction({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.confidence,
    required this.classLabel,
    required this.classId,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      x: json['x'].toDouble(),
      y: json['y'].toDouble(),
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      confidence: json['confidence'].toDouble(),
      classLabel: json['class'],
      classId: json['class_id'],
    );
  }
}
