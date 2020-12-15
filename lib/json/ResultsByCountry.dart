class ResultsByCountry {
  String country;
  int totalVotes;

  ResultsByCountry({this.country, this.totalVotes});

  ResultsByCountry.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    totalVotes = json['totalVotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['totalVotes'] = this.totalVotes;
    return data;
  }
}
