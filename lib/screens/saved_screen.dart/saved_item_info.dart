class SavedItemInfo {
  final String image;
  final String time;
  final String title;
  final String location;
  final double star;
  final bool like;
  SavedItemInfo({
    required this.image,
    required this.time,
    required this.title,
    required this.location,
    required this.star,
    required this.like,
  });
}

List<SavedItemInfo> savedItems = [];
