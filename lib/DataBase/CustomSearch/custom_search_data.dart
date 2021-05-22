class CustomSearchData {
  int id;
  String title;
  String webSite;
  CustomSearchData({this.id, this.title, this.webSite});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "WebSite": webSite,
    };
  }
}
