class MenuItemModel {
  const MenuItemModel({
    required this.title,
    required this.iconPath,
    this.isImage = false,
    this.routeName,
  });

  final String title;
  final String iconPath;
  final bool isImage;
  final String? routeName;
}
