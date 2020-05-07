class Manga {
  final int id;
  final String title;
  final String description;
  final String imgUrl;
  final double score;
  Manga({this.id, this.title, this.description, this.imgUrl, this.score});
  @override
  String toString() {
    return '\n id: $id \n title: $title \n description: ${description.substring(0, 50)}... \n image: $imgUrl \n score: $score \n';
  }
}
