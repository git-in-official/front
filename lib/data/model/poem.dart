class Poem {
  final String id;
  final String title;
  final String content;
  final String textAlign;
  final int textSize;
  final String textFont;
  final List<String> themes;
  final List<String> interactions;
  final bool isRecorded;
  final String? audioUrl;
  final DateTime createdAt;
  final String inspirationId;
  final String authorId;
  final String authorName;
  final bool isScrapped;

  Poem({
    required this.id,
    required this.title,
    required this.content,
    required this.textAlign,
    required this.textSize,
    required this.textFont,
    required this.themes,
    required this.interactions,
    required this.isRecorded,
    this.audioUrl,
    required this.createdAt,
    required this.inspirationId,
    required this.authorId,
    required this.authorName,
    required this.isScrapped,
  });

  factory Poem.fromJson(Map<String, dynamic> json) {
    return Poem(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      textAlign: json['textAlign'],
      textSize: json['textSize'],
      textFont: json['textFont'],
      themes: List<String>.from(json['themes']),
      interactions: List<String>.from(json['interactions']),
      isRecorded: json['isRecorded'],
      audioUrl: json['audioUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      inspirationId: json['inspirationId'],
      authorId: json['author']['id'],
      authorName: json['author']['name'],
      isScrapped: json['isScrapped'],
    );
  }
}
