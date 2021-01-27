class ResultsByCountry {
  String country;
  List<Candidates> candidates;
  int totalVotes;

  ResultsByCountry({this.country, this.candidates});

  ResultsByCountry.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    if (json['candidates'] != null) {
      candidates = new List<Candidates>();
      json['candidates'].forEach((v) {
        candidates.add(new Candidates.fromJson(v));
      });
    }
    totalVotes = candidates.fold(
        0, (previousValue, candidate) => previousValue + candidate.totalVotes);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    if (this.candidates != null) {
      data['candidates'] = this.candidates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Candidates {
  String candidate;
  int totalVotes;

  Candidates({this.candidate, this.totalVotes});

  Candidates.fromJson(Map<String, dynamic> json) {
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
