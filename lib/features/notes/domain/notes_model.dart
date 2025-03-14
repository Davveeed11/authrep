class NotesModel {
  final String id;
  final String title;
  final String contents;

  NotesModel({required this.id, required this.title, required this.contents});

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'contents': contents};
  }

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      contents: json['contents'] ?? '',
    );
  }
}
