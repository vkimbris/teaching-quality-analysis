import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:xakaton/assets/colors/app_colors.dart';
import 'package:xakaton/assets/theme/app_theme.dart';
import 'package:xakaton/features/main/screens/main_screen_widget_model.dart';
import 'package:xakaton/features/main/widgets/drag_drop_widget.dart';
import 'package:xakaton/features/main/widgets/lessons_widget.dart';

/// Main widget for MainScreen module
class MainScreen extends ElementaryWidget<IMainScreenWidgetModel> {
  const MainScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultMainScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMainScreenWidgetModel wm) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: TabBar(
                indicatorColor: AppColors.accent,
                indicatorWeight: 1,
                controller: wm.tabController,
                tabs: [
                  Tab(
                    child: Text(
                      'Загрузка',
                      style: AppTheme.textStyle.copyWith(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Уроки',
                      style: AppTheme.textStyle.copyWith(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
            ),
            child: TabView(
              tabController: wm.tabController,
              childSecond: SizedBox(
                child: LessonsWidget(
                  lessonsState: wm.lessonsListState,
                  onLessonCardTap: wm.onLessonCardTap,
                ),
              ),
              childFirst: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DragDropWidget(
                    isHighlighted: wm.isDragDropHighlited,
                    onCreated: wm.dragDropOnCreated,
                    onDrop: wm.dragDropOnDrop,
                    onError: wm.dragDropOnError,
                    onHover: wm.dragDropOnHover,
                    onLeave: wm.dragDropOnLeave,
                    onLoaded: wm.dragDropOnLoaded,
                    onFilePickerPressed: wm.onFilePickerPressed,
                    isLoading: wm.isDragDropLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Вью для табов.
class TabView extends StatefulWidget {
  final TabController tabController;

  final Widget childFirst;
  final Widget childSecond;

  const TabView({
    super.key,
    required this.tabController,
    required this.childFirst,
    required this.childSecond,
  });

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: [
        widget.childFirst,
        widget.childSecond,
      ],
    );
  }
}
