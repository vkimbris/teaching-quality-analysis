import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:xakaton/assets/colors/app_colors.dart';
import 'package:xakaton/assets/theme/app_theme.dart';

class DragDropWidget extends StatelessWidget {
  final ValueListenable<bool> isHighlighted;
  final ValueListenable<bool> isLoading;
  final Future<void> Function(dynamic) onDrop;
  final void Function() onFilePickerPressed;
  final void Function(DropzoneViewController) onCreated;
  final void Function() onHover;
  final void Function() onLeave;
  final void Function() onLoaded;
  final void Function(String?) onError;

  const DragDropWidget({
    super.key,
    required this.isHighlighted,
    required this.onDrop,
    required this.onCreated,
    required this.onHover,
    required this.onLeave,
    required this.onLoaded,
    required this.onError,
    required this.onFilePickerPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isHighlighted,
      builder: (context, value, child) => Container(
        constraints: const BoxConstraints(
          minHeight: 200,
          minWidth: 400,
          maxHeight: 600,
          maxWidth: 1200,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isHighlighted.value ? AppColors.grey : AppColors.accent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            DropzoneView(
              onDrop: onDrop,
              onCreated: onCreated,
              onError: onError,
              onHover: onHover,
              onLeave: onLeave,
              onLoaded: onLoaded,
            ),
            ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, isLoading, child) {
                  return isLoading
                      ? const SizedBox.square(
                          dimension: 80,
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColors.white),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              size: 80,
                              color: AppColors.white,
                            ),
                            Text(
                              "Перетащите и отпустите '.xlsx' файл сюда \nили",
                              textAlign: TextAlign.center,
                              style: AppTheme.textStyle.copyWith(
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            FilePickerWidget(
                              onPressed: onFilePickerPressed,
                            ),
                          ],
                        );
                }),
          ],
        ),
      ),
    );
  }
}

class FilePickerWidget extends StatelessWidget {
  final void Function() onPressed;
  const FilePickerWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        'Выбрать файл',
        maxLines: 1,
        style: AppTheme.textStyle.copyWith(
          fontSize: 18,
        ),
      ),
    );
  }
}
