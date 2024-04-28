import 'package:xakaton/api/data/statisctics_dto.dart';
import 'package:xakaton/features/main/domain/entity/marks.dart';
import 'package:xakaton/features/main/domain/entity/stats.dart';

class Statistics {
  final List<Stats> stats;
  final List<Marks> marks;

  Statistics({required this.stats, required this.marks});

  static Statistics fromStatisticsDTO(StatisticsDTO dto) {
    return Statistics(
      stats: dto.stats.map((e) => Stats.fromStatsDTO(e)).toList(),
      marks: dto.marks.map((e) => Marks.fromMarksDTO(e)).toList(),
    );
  }
}
