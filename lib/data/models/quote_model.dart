class QuoteModel {
  final String quote, author;

  QuoteModel.fromJson(Map<String, dynamic> json)
      : quote = json['quote'],
        author = json['author'];
}
