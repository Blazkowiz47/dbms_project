class Scholarship {
  final int schid;
  final int uniId;
  final int schDuration;
  final String season;
  final String? funding;
  final String gender;
  final int maxAge;
  final String eligibility;
  final String? country;
  final String? discipline;
  bool applied;

  Scholarship({
    required this.schid,
    required this.uniId,
    required this.schDuration,
    required this.season,
    required this.funding,
    required this.gender,
    required this.maxAge,
    required this.eligibility,
    required this.country,
    required this.discipline,
    required this.applied,
  });
}
