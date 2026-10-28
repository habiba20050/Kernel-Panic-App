import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(const KernelPanicApp());
}

class KernelPanicApp extends StatelessWidget {
  const KernelPanicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kernel Panic',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
