import 'package:flutter/material.dart';
import 'package:xakaton/assets/theme/app_theme.dart';
import 'package:xakaton/core/di/di_scope.dart';
import 'package:xakaton/core/navigation/app_router.dart';
import 'package:xakaton/features/main/di/base/main_scope_interface.dart';
import 'package:xakaton/features/main/di/main_scope.dart';

/// App widget.
// ignore: must_be_immutable
class App extends StatefulWidget {
  /// Create an instance App.
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// Onboarding done state.
  late IMainScope _scope;

  @override
  void initState() {
    super.initState();
    _scope = MainScope();
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IMainScope>(
      key: ObjectKey(_scope),
      factory: () => _scope,
      child: MaterialApp(
        /// Debug configuration.
        showPerformanceOverlay: false,
        debugShowMaterialGrid: false,
        checkerboardRasterCacheImages: false,
        checkerboardOffscreenLayers: false,
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,

        initialRoute: AppRouter.mainScreen,
        onGenerateRoute: (routeSettings) =>
            AppRouter.routes[routeSettings.name]!(routeSettings.arguments),

        theme: AppTheme.theme,
      ),
    );
  }
}
