import 'package:society_managment/society_management.dart';

enum Gender {
  male(value: "male"),
  female(value: "female");

  const Gender({required this.value});

  final String value;

  static Gender fromValue(String value) {
    return Gender.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Gender.male,
    );
  }
}

enum FamilyMemberRelation {
  father(value: "Father"),
  mother(value: "Mother"),
  son(value: "Son"),
  daughter(value: "Daughter"),
  brother(value: "Brother"),
  sister(value: "Sister");

  const FamilyMemberRelation({required this.value});

  final String value;

  static FamilyMemberRelation fromValue(String value) {
    return FamilyMemberRelation.values.firstWhere(
      (e) => e.value == value,
      orElse: () => .father,
    );
  }

  static String getString(BuildContext context, FamilyMemberRelation relation) {
    switch (relation) {
      case .father:
        return context.l10n?.father ?? "";
      case .mother:
        return context.l10n?.mother ?? "";
      case .son:
        return context.l10n?.son ?? "";
      case .daughter:
        return context.l10n?.daughter ?? "";
      case .brother:
        return context.l10n?.brother ?? "";
      case .sister:
        return context.l10n?.sister ?? "";
    }
  }

  static Color getColor(FamilyMemberRelation relation) {
    switch (relation) {
      case .father:
        return Color(0XFF106FD5);
      case .mother:
        return Color(0XFFDD6C1B);
      case .son:
        return Color(0XFF107917);
      case .daughter:
        return Color(0xFFD51083);
      case .brother:
        return Color(0XFFAE10D5);
      case .sister:
        return Color(0xFFD59310);
    }
  }

  static List<FamilyMemberRelation> getRelationsList(BuildContext context) {
    return [.father, .mother, .son, .daughter, .brother, .sister];
  }
}
