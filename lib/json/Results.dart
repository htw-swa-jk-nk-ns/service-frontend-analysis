class Results {
  String candidate;
  int totalVotes;

  Results({this.candidate, this.totalVotes});

  Results.fromJson(Map<String, dynamic> json) {
    candidate = json['candidate'];
    totalVotes = json['totalVotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate'] = this.candidate;
    data['totalVotes'] = this.totalVotes;
    return data;
  }
}
