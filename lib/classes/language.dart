class Language {
  final int id;
  final String lanCode;
  final String name;

  Language(this.id, this.name, this.lanCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "English", "en"),
      Language(2, "עברית", "he"),
      Language(3, "عربي", "ar")
    ];
  }
}
