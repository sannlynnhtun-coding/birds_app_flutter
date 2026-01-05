class Bird {
  final int id;
  final String birdMyanmarName;
  final String birdEnglishName;
  final String description;
  final String imagePath;

  Bird({
    required this.id,
    required this.birdMyanmarName,
    required this.birdEnglishName,
    required this.description,
    required this.imagePath,
  });

  factory Bird.fromJson(Map<String, dynamic> json) {
    return Bird(
      id: json['Id'],
      birdMyanmarName: json['BirdMyanmarName'],
      birdEnglishName: json['BirdEnglishName'],
      description: json['Description'],
      imagePath: json['ImagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BirdMyanmarName': birdMyanmarName,
      'BirdEnglishName': birdEnglishName,
      'Description': description,
      'ImagePath': imagePath,
    };
  }

  Bird copyWith({
    int? id,
    String? birdMyanmarName,
    String? birdEnglishName,
    String? description,
    String? imagePath,
  }) {
    return Bird(
      id: id ?? this.id,
      birdMyanmarName: birdMyanmarName ?? this.birdMyanmarName,
      birdEnglishName: birdEnglishName ?? this.birdEnglishName,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

