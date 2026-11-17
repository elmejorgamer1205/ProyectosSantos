class HeroExtra {
  const HeroExtra({required this.heroId, required this.team, required this.extraInfo});

  final String heroId;
  final String team;
  final String extraInfo;

  factory HeroExtra.fromJson(Map<String, dynamic> json) {
    final id = json['hero_id'];
    final team = json['team'];
    final info = json['extra_info'];
    if (id is! String || team is! String || info is! String) {
      throw const FormatException('JSON incompleto o con tipos incorrectos');
    }
    return HeroExtra(heroId: id, team: team, extraInfo: info);
  }
}
