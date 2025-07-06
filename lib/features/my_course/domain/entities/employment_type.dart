enum EmploymentType {
  fullTime('Full Time'),
  partTime('Part Time'),
  internship('Internship'),
  freelance('Freelance'),
  contract('Contract');

  final String displayName;
  const EmploymentType(this.displayName);

  static EmploymentType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'full time':
      case 'fulltime':
        return EmploymentType.fullTime;
      case 'part time':
      case 'parttime':
        return EmploymentType.partTime;
      case 'internship':
        return EmploymentType.internship;
      case 'freelance':
        return EmploymentType.freelance;
      case 'contract':
        return EmploymentType.contract;
      default:
        return EmploymentType.fullTime;
    }
  }

  static List<String> get displayNames =>
      EmploymentType.values.map((e) => e.displayName).toList();
}
