import 'package:xakaton/api/data/category_dto.dart';

class Category {
  final String name;
  final double score;

  const Category({
    required this.name,
    required this.score,
  });

  static Category fromCategoryDTO(CategoryDTO dto) {
    return Category(name: dto.name, score: dto.score);
  }

  static CategoryDTO toCategoryDTO(Category cat) {
    return CategoryDTO(name: cat.name, score: cat.score);
  }
}
