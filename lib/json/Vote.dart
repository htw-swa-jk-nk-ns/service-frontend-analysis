class Vote {
  String country;
  String name;
  int voteFor;
  String date;
  int id;

  Vote();

  @override
  String toString() {
    return 'Vote[country=$country, name=$name, voteFor=$voteFor, date=$date, id=$id, ]';
  }

  Vote.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    country = json['country'];
    name = json['name'];
    voteFor = json['voteFor'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'name': name,
      'voteFor': voteFor,
      'date': date,
      'id': id
    };
  }

  static List<Vote> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<Vote>()
        : json.map((value) => new Vote.fromJson(value)).toList();
  }

  static Map<String, Vote> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Vote>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new Vote.fromJson(value));
    }
    return map;
  }
}
