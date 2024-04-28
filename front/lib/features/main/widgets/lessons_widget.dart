import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xakaton/assets/colors/app_colors.dart';
import 'package:xakaton/assets/theme/app_theme.dart';
import 'package:xakaton/core/widgets/custom_circular_indicator.dart';
import 'package:xakaton/features/main/domain/entity/lesson.dart';

class LessonsWidget extends StatelessWidget {
  final Function(Lesson lessonData) onLessonCardTap;
  final ValueListenable<EntityState<List<Lesson>>> lessonsState;
  final scrollController = ScrollController();
  LessonsWidget({
    super.key,
    required this.lessonsState,
    required this.onLessonCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder(
      listenableEntityState: lessonsState,
      loadingBuilder: (_, __) =>
          const Center(child: CustomCircularProgressIndicator()),
      builder: (_, value) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width *
                  0.6, // Максимальная ширина контейнера
              maxHeight: MediaQuery.of(context).size.height *
                  0.8, // Максимальная высота контейнера
            ),
            decoration: AppTheme.shadowBoxDecoration,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _HeaderWidget(),
                const Divider(
                  color: AppColors.liner,
                  thickness: 3,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: scrollController,
                    trackVisibility: true,
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: value!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final lessons = value[index];
                        return LessonCard(
                          date: lessons.dateStart,
                          id: lessons.id,
                          onTap: () => onLessonCardTap(value[index]),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return index != value.length - 1
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Divider(
                                  color: AppColors.liner,
                                  thickness: 1,
                                ),
                              )
                            : const SizedBox();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24)
              ],
            ),
          ),
        );
      },
    );
  }
}

class LessonCard extends StatelessWidget {
  final int id;
  final DateTime date;
  final VoidCallback onTap;

  const LessonCard({
    super.key,
    required this.id,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Урок #$id',
                  style: AppTheme.textStyle.copyWith(fontSize: 18)),
              const SizedBox(
                width: 40,
              ),
              Text('Дата: $date', style: AppTheme.hintStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            'Доступные уроки',
            style: AppTheme.headerStyle.copyWith(color: AppColors.dark),
          ),
        ],
      ),
    );
  }
}
