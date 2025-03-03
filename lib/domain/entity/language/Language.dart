// ignore_for_file: file_names
class Language {
  /// the country code (IT,AF..)
  String code;

  /// the locale (en, es, da)
  String locale;

  /// the full name of language (English, Danish..)
  String language;

  /// map of keys used based on industry type (service worker, route etc)
  Map<String, String>? dictionary;

  Language({
    required this.code,
    required this.locale,
    required this.language,
    this.dictionary,
  });
}
