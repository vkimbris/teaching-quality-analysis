// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:d_chart/d_chart.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'package:xakaton/assets/colors/app_colors.dart';
import 'package:xakaton/assets/theme/app_theme.dart';
import 'package:xakaton/features/lesson_analyze/screens/lesson_analyze_screen_widget_model.dart';
import 'package:xakaton/features/main/domain/entity/lesson.dart';
import 'package:xakaton/features/main/domain/entity/marks.dart';
import 'package:xakaton/features/main/domain/entity/message.dart';
import 'package:xakaton/features/main/domain/entity/statistics.dart';
import 'package:xakaton/features/main/domain/entity/summary.dart';

class LessonAnalyzeScreen extends ElementaryWidget<ILessonAnalyzeScreenWidgetModel> {
  LessonAnalyzeScreen({
    Key? key,
    required Lesson lesson,
  }) : super((ctx) => defaultLessonAnalyzeScreenWidgetModelFactory(ctx, lesson), key: key);

  @override
  Widget build(ILessonAnalyzeScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
              minHeight: 80,
              maxHeight: 160,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: Navigator.of(wm.ctx).pop, // Handle your onTap
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Урок #${wm.lessonData.id}',
                        style: AppTheme.headerStyle,
                      ),
                      Text(
                        'Дата:${wm.lessonData.dateStart}',
                        style: AppTheme.subheaderStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: AppColors.liner,
            height: 4,
          ),
          Expanded(
            child: _BodyWidget(
              chatScrollController: wm.chatScrollController,
              messagesListState: wm.messagesListState,
              onAnalyzePressed: wm.onAnalyzePressed,
              statsState: wm.statsState,
              summaryEntityState: wm.summaryEntityState,
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  final ValueListenable<EntityState<List<Message>>> messagesListState;
  final ValueListenable<EntityState<Statistics>> statsState;
  final ValueListenable<EntityState<SummaryEntity>> summaryEntityState;
  final ScrollController chatScrollController;
  final VoidCallback onAnalyzePressed;

  const _BodyWidget({
    required this.chatScrollController,
    required this.messagesListState,
    required this.onAnalyzePressed,
    required this.statsState,
    required this.summaryEntityState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: EntityStateNotifierBuilder(
        listenableEntityState: messagesListState,
        builder: (BuildContext context, data) {
          if (data == null) {
            return NoDataWidget(
              onAnalyzePressed: onAnalyzePressed,
              messagesListState: messagesListState,
            );
          } else {
            return UiWidget(
              child1: Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'История чата',
                        style: AppTheme.headerStyle.copyWith(color: AppColors.dark, fontSize: 28),
                      ),
                    ),
                    const Divider(
                      color: AppColors.liner,
                      thickness: 3,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: VsScrollbar(
                        controller: chatScrollController,
                        showTrackOnHover: true, // default false
                        isAlwaysShown: true, // default false
                        scrollbarFadeDuration: const Duration(
                            milliseconds: 500), // default : Duration(milliseconds: 300)
                        scrollbarTimeToFade: const Duration(
                            milliseconds: 800), // default : Duration(milliseconds: 600)
                        style: VsScrollbarStyle(
                          hoverThickness: 10.0, // default 12.0
                          radius: const Radius.circular(10), // default Radius.circular(8.0)
                          thickness: 10.0, // [ default 8.0 ]
                          color: Colors.purple.shade900, // default ColorScheme Theme
                        ),
                        child: ListView.separated(
                          controller: chatScrollController,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final element = data[index];
                            final sortedCategories = element.categories;
                            element.categories.sort((a, b) => a.name.compareTo(b.name));

                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                title: Text(
                                  element.text,
                                  style: AppTheme.textStyle,
                                ),
                                subtitle: Text(
                                  data[index].date.toString(),
                                  style: AppTheme.hintStyle,
                                ),
                                leading: Icon(
                                  !data[index].isAdmin ? Icons.person : Icons.chat_bubble,
                                ),
                                trailing: LeadingRow(
                                  value1: sortedCategories.elementAt(0).score,
                                  value2: sortedCategories.elementAt(1).score,
                                  value3: sortedCategories.elementAt(2).score,
                                  value4: sortedCategories.elementAt(3).score,
                                ),
                                iconColor: AppColors.accent,
                              ),
                            );
                          },
                          separatorBuilder: (_, int index) {
                            return index != data.length - 1
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: AppTheme.shadowBoxDecoration.copyWith(
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Все отлично',
                                  style: AppTheme.textStyle
                                      .copyWith(color: AppColors.dark, fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: AppTheme.shadowBoxDecoration.copyWith(
                                    color: Colors.amber,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Ругательство',
                                  style: AppTheme.textStyle
                                      .copyWith(color: AppColors.dark, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: AppTheme.shadowBoxDecoration.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Сложности в понимании',
                                  style: AppTheme.textStyle
                                      .copyWith(color: AppColors.dark, fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: AppTheme.shadowBoxDecoration.copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Технические неполадки',
                                  style: AppTheme.textStyle
                                      .copyWith(color: AppColors.dark, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              child2: Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Объяснение поведения',
                        style: AppTheme.headerStyle.copyWith(color: AppColors.dark, fontSize: 28),
                      ),
                    ),
                    const Divider(
                      color: AppColors.liner,
                      thickness: 3,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: EntityStateNotifierBuilder(
                        loadingBuilder: (_, __) => const Center(
                          child: SizedBox.square(
                            dimension: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                            ),
                          ),
                        ),
                        listenableEntityState: summaryEntityState,
                        builder: (_, data) {
                          return Expanded(
                            child: Text(
                              data!.text,
                              style: AppTheme.textStyle.copyWith(fontSize: 18),
                              textAlign: TextAlign.start,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              child3: EntityStateNotifierBuilder(
                listenableEntityState: statsState,
                loadingBuilder: (_, __) => const Center(
                  child: SizedBox.square(
                    dimension: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                    ),
                  ),
                ),
                builder: (_, value) {
                  final data = value!.stats;
                  List<OrdinalData> ordinalDataList = [
                    OrdinalData(
                        domain: data.elementAt(0).category,
                        measure: data.elementAt(0).value,
                        color: Colors.green),
                    OrdinalData(
                        domain: data.elementAt(2).category,
                        measure: data.elementAt(2).value,
                        color: Colors.amber),
                    OrdinalData(
                        domain: data.elementAt(3).category,
                        measure: data.elementAt(3).value,
                        color: Colors.blue),
                    OrdinalData(
                        domain: data.elementAt(4).category,
                        measure: data.elementAt(4).value,
                        color: Colors.red),
                    OrdinalData(
                      domain: data.elementAt(1).category,
                      measure: data.elementAt(1).value,
                      color: AppColors.grey,
                    ),
                  ];

                  return Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Распределение сообщений по категориям',
                            style:
                                AppTheme.headerStyle.copyWith(color: AppColors.dark, fontSize: 28),
                          ),
                        ),
                        const Divider(
                          color: AppColors.liner,
                          thickness: 3,
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(flex: 5),
                              Expanded(
                                flex: 40,
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: DChartPieO(
                                    data: ordinalDataList,
                                    configRenderPie: const ConfigRenderPie(
                                      arcWidth: 45,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(flex: 5),
                              const Expanded(
                                flex: 40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PieChartInfoRow(
                                      color: Colors.green,
                                      text: 'Все отлично',
                                    ),
                                    SizedBox(height: 8),
                                    PieChartInfoRow(
                                      color: Colors.amber,
                                      text: 'Ругательство',
                                    ),
                                    SizedBox(height: 8),
                                    PieChartInfoRow(
                                      color: Colors.blue,
                                      text: 'Сложности в понимании',
                                    ),
                                    SizedBox(height: 8),
                                    PieChartInfoRow(
                                      color: Colors.red,
                                      text: 'Технические неполадки',
                                    ),
                                    SizedBox(height: 8),
                                    PieChartInfoRow(
                                      color: Colors.grey,
                                      text: 'Ничего',
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              child4: Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Оценка урока',
                        style: AppTheme.headerStyle.copyWith(color: AppColors.dark, fontSize: 28),
                      ),
                    ),
                    const Divider(
                      color: AppColors.liner,
                      thickness: 3,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: EntityStateNotifierBuilder(
                          listenableEntityState: statsState,
                          loadingBuilder: (_, __) => const Center(
                                child: SizedBox.square(
                                  dimension: 40,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                                  ),
                                ),
                              ),
                          builder: (_, value) {
                            final data = value!.marks;
                            return RatingInfoWidget(marks: data);
                          }),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  final ValueListenable<EntityState<List<Message>>> messagesListState;
  final VoidCallback onAnalyzePressed;

  const NoDataWidget({super.key, required this.onAnalyzePressed, required this.messagesListState});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 300,
        decoration: AppTheme.shadowBoxDecoration,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              color: AppColors.accent,
              size: 60,
            ),
            const SizedBox(height: 24),
            EntityStateNotifierBuilder(
              builder: (context, value) {
                return ElevatedButton(
                  onPressed: onAnalyzePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Проанализировать',
                    style: AppTheme.textStyle.copyWith(
                      color: AppColors.white,
                      fontSize: 18,
                    ),
                  ),
                );
              },
              loadingBuilder: (_, data) {
                return const SizedBox.square(
                  dimension: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                  ),
                );
              },
              listenableEntityState: messagesListState,
            ),
          ],
        ),
      ),
    );
  }
}

class RatingInfoWidget extends StatelessWidget {
  final List<Marks> marks;
  const RatingInfoWidget({super.key, required this.marks});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 15),
        Expanded(
          flex: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${marks.elementAt(0).category}:',
                style: AppTheme.subheaderStyle,
              ),
              const SizedBox(width: 8),
              RatingBar.readOnly(
                filledIcon: Icons.star,
                filledColor: AppColors.accent,
                emptyIcon: Icons.star_border,
                initialRating: marks.elementAt(0).value,
                maxRating: 5,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${marks.elementAt(1).category}:',
                style: AppTheme.subheaderStyle,
              ),
              const SizedBox(width: 8),
              RatingBar.readOnly(
                filledIcon: Icons.star,
                filledColor: AppColors.accent,
                emptyIcon: Icons.star_border,
                initialRating: marks.elementAt(1).value,
                maxRating: 5,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${marks.elementAt(2).category}:',
                style: AppTheme.subheaderStyle,
              ),
              const SizedBox(width: 8),
              RatingBar.readOnly(
                filledIcon: Icons.star,
                filledColor: AppColors.accent,
                emptyIcon: Icons.star_border,
                initialRating: marks.elementAt(2).value,
                maxRating: 5,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${marks.elementAt(3).category}:',
                style: AppTheme.subheaderStyle,
              ),
              const SizedBox(width: 8),
              RatingBar.readOnly(
                filledIcon: Icons.star,
                filledColor: AppColors.accent,
                emptyIcon: Icons.star_border,
                initialRating: marks.elementAt(3).value,
                maxRating: 5,
              ),
            ],
          ),
        ),
        const Spacer(flex: 15),
      ],
    );
  }
}

class PieChartInfoRow extends StatelessWidget {
  final Color color;
  final String text;

  const PieChartInfoRow({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: AppTheme.shadowBoxDecoration.copyWith(color: color),
          height: 30,
          width: 30,
        ),
        const SizedBox(width: 8),
        Text(text, style: AppTheme.textStyle),
      ],
    );
  }
}

class LeadingRow extends StatelessWidget {
  final double value1;
  final double value2;
  final double value3;
  final double value4;

  const LeadingRow({
    super.key,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularPercentIndicator(
          radius: 22.0,
          lineWidth: 8.0,
          percent: value1,
          progressColor: Colors.green,
          center: Text(
            (value1 * 100).toStringAsFixed(1),
            style: AppTheme.hintStyle.copyWith(fontSize: 12),
          ),
        ),
        const SizedBox(width: 8),
        CircularPercentIndicator(
            radius: 22.0,
            lineWidth: 8.0,
            percent: value2,
            progressColor: Colors.amber,
            center: Text(
              (value2 * 100).toStringAsFixed(1),
              style: AppTheme.hintStyle.copyWith(fontSize: 12),
            )),
        const SizedBox(width: 8),
        CircularPercentIndicator(
          radius: 22.0,
          lineWidth: 8.0,
          percent: value3,
          progressColor: Colors.blue,
          center: Text(
            (value3 * 100).toStringAsFixed(1),
            style: AppTheme.hintStyle.copyWith(fontSize: 12),
          ),
        ),
        const SizedBox(width: 8),
        CircularPercentIndicator(
          radius: 22.0,
          lineWidth: 8.0,
          percent: value4,
          progressColor: Colors.red,
          center: Text(
            (value4 * 100).toStringAsFixed(1),
            style: AppTheme.hintStyle.copyWith(fontSize: 12),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class UiWidget extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final Widget? child3;
  final Widget? child4;

  const UiWidget({
    super.key,
    required this.child1,
    required this.child2,
    required this.child3,
    required this.child4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(flex: 10),
        Expanded(
          flex: 45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 60,
                child: AspectRatio(
                  aspectRatio: 447 / 330,
                  child: GridTileWidget(
                    child: child1,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 20,
                child: AspectRatio(
                  aspectRatio: 815 / 200,
                  child: GridTileWidget(
                    child: child2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 30,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 50,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Visibility(
                    visible: child3 != null,
                    child: GridTileWidget(
                      child: child3 ?? const SizedBox(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 50,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Visibility(
                    visible: child4 != null,
                    child: GridTileWidget(
                      child: child4 ?? const SizedBox(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(flex: 10),
      ],
    );
  }
}

class GridTileWidget extends StatelessWidget {
  final Widget child;
  const GridTileWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.shadowBoxDecoration,
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
