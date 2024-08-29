class PoemResponse {
  final String id;
  final String title;
  final String content;
  final String textAlign;
  final int textSize;
  final String textFont;
  final List<String> themes;
  final List<String> interactions;
  final bool isRecorded;
  final String status;
  final DateTime createdAt;
  final String authorId;
  final String inspirationId;
  final String audioUrl;

  PoemResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.textAlign,
    required this.textSize,
    required this.textFont,
    required this.themes,
    required this.interactions,
    required this.isRecorded,
    required this.status,
    required this.createdAt,
    required this.authorId,
    required this.inspirationId,
    required this.audioUrl,
  });

  factory PoemResponse.fromJson(Map<String, dynamic> json) {
    return PoemResponse(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      textAlign: json['textAlign'],
      textSize: json['textSize'],
      textFont: json['textFont'],
      themes: List<String>.from(json['themes']),
      interactions: List<String>.from(json['interactions']),
      isRecorded: json['isRecorded'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      authorId: json['authorId'],
      inspirationId: json['inspirationId'],
      audioUrl: json['audioUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'textAlign': textAlign,
      'textSize': textSize,
      'textFont': textFont,
      'themes': themes,
      'interactions': interactions,
      'isRecorded': isRecorded,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'authorId': authorId,
      'inspirationId': inspirationId,
      'audioUrl': audioUrl,
    };
  }
}
