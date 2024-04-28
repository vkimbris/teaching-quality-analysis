import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';
import 'package:xakaton/assets/colors/app_colors.dart';
import 'package:xakaton/core/navigation/app_router.dart';
import 'package:xakaton/features/main/di/base/main_scope_interface.dart';
import 'package:xakaton/features/main/domain/entity/lesson.dart';
import 'package:xakaton/features/main/screens/main_screen.dart';
import 'package:xakaton/features/main/screens/main_screen_model.dart';

MainScreenWidgetModel defaultMainScreenWidgetModelFactory(BuildContext context) {
  final model = MainScreenModel(Provider.of<IMainScope>(context).databaseApiInteractor);

  return MainScreenWidgetModel(context, model);
}

/// Default widget model for MainScreenWidget
class MainScreenWidgetModel extends WidgetModel<MainScreen, MainScreenModel>
    with SingleTickerProviderWidgetModelMixin
    implements IMainScreenWidgetModel {
  /// Create an instance [MainScreenWidgetModel].
  MainScreenWidgetModel(
    this._ctx,
    MainScreenModel model,
  ) : super(model);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_handleTabSelection);
    super.dispose();
  }

  final _lessonsListState = EntityStateNotifier<List<Lesson>>();

  /// Контекст.
  final BuildContext _ctx;

  /// Контроллер дропа.
  late DropzoneViewController _dragDropController;

  /// Подсвечивает при ховере драгдропа.
  final _isDragDropHighlited = ValueNotifier<bool>(false);

  final _isDragDropLoading = ValueNotifier<bool>(false);

  late final TabController _tabController;

  @override
  BuildContext get ctx => _ctx;

  @override
  ValueListenable<bool> get isDragDropHighlited => _isDragDropHighlited;

  @override
  Future<void> dragDropOnDrop(dynamic event) async {
    final name = event.name;

    _isDragDropLoading.value = true;
    if (!isFileNameValid(name)) {
      _isDragDropHighlited.value = false;
      _dragDropOnErrorShowSnackBar("Расширение файла должно быть '.xlsx'");

      _isDragDropLoading.value = false;
      return;
    }

    final data = await _dragDropController.getFileData(event);

    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(data, filename: name),
    });

    await model.databaseApiInteractor.uploadFile(formData);

    _isDragDropLoading.value = false;
    //Update the UI
    //widget.onDroppedFile(droppedFile);
    _isDragDropHighlited.value = false;
  }

  @override
  void dragDropOnHover() {
    _isDragDropHighlited.value = true;
  }

  @override
  void dragDropOnLeave() {
    _isDragDropHighlited.value = false;
  }

  @override
  void dragDropOnLoaded() {}

  @override
  void dragDropOnError(String? error) {
    _dragDropOnErrorShowSnackBar(error);
  }

  @override
  void dragDropOnCreated(DropzoneViewController controller) {
    _dragDropController = controller;
  }

  /// Проверка на расширение файла.
  bool isFileNameValid(String filename) {
    return filename.endsWith('.xlsx');
  }

  void _dragDropOnErrorShowSnackBar([String? msg]) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(_ctx).showSnackBar(getErrorSnackBar(msg ?? 'проблема с загрузкой файла'));
  }

  @override
  void onFilePickerPressed() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    _isDragDropLoading.value = true;
    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;
      String fileName = result.files.first.name;

      if (!isFileNameValid(fileName)) {
        _isDragDropHighlited.value = false;
        _dragDropOnErrorShowSnackBar("Расширение файла должно быть '.xlsx'");

        _isDragDropLoading.value = false;
        return;
      }

      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(fileBytes, filename: fileName),
      });

      await model.databaseApiInteractor.uploadFile(formData);
      //await FileSaver.instance.saveFile(name: fileName, bytes: fileBytes);
      _isDragDropLoading.value = false;
    }
  }

  @override
  ValueListenable<bool> get isDragDropLoading => _isDragDropLoading;

  @override
  TabController get tabController => _tabController;

  @override
  ValueListenable<EntityState<List<Lesson>>> get lessonsListState => _lessonsListState;

  Future<void> _handleTabSelection() async {
    if (tabController.previousIndex == 0 && tabController.index == 1) {
      if (!_lessonsListState.value.isLoadingState) {
        await _loadLessons();
      }
    }
  }

  Future<void> _loadLessons() async {
    final previousData = _lessonsListState.value.data;

    _lessonsListState.loading();

    try {
      final res = await model.getLessons();
      _lessonsListState.content(res);
    } on Exception catch (e) {
      _lessonsListState.error(e, previousData);
    }
  }

  @override
  void onLessonCardTap(Lesson lessonData) {
    Navigator.of(context).pushNamed(AppRouter.lessonAnalyzeScreen, arguments: lessonData);
  }
}

abstract class IMainScreenWidgetModel implements IWidgetModel {
  /// Build context.
  BuildContext get ctx;

  TabController get tabController;

  /// --- DragDrop

  ValueListenable<bool> get isDragDropHighlited;

  ValueListenable<bool> get isDragDropLoading;

  Future<void> dragDropOnDrop(dynamic event);

  void dragDropOnCreated(DropzoneViewController controller);

  void dragDropOnHover();

  void dragDropOnLeave();

  void dragDropOnLoaded();

  void dragDropOnError(String? error);

  /// --- File Picker
  void onFilePickerPressed();

  ValueListenable<EntityState<List<Lesson>>> get lessonsListState;

  void onLessonCardTap(Lesson lessonData);
}

/// Снекбар с ошибкой
SnackBar getErrorSnackBar([String? msg]) {
  return SnackBar(
    backgroundColor: Colors.red,
    elevation: 0,
    width: 300,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    content: Text(
      'Ошибка: $msg.',
      style: const TextStyle(
        color: AppColors.white,
      ),
    ),
  );
}
