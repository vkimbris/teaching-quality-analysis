import 'package:xakaton/api/data/stats_dto.dart';

class Stats {
  final int value;

  final String category;

  Stats({required this.value, required this.category});

  static Stats fromStatsDTO(StatsDTO dto) {
    return Stats(category: dto.category, value: dto.value);
  }
}
