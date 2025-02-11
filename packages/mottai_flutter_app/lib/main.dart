import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'development/development_items/ui/development_items.dart';
import 'firebase_options.dart';
import 'package_info.dart';
import 'scaffold_messenger_controller.dart';
import 'user/user.dart';
import 'user/user_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final container = ProviderContainer();
  final hostDocumentExists =
      await container.read(hostDocumentExistsProvider).call();
  container.dispose();
  runApp(
    ProviderScope(
      overrides: [
        packageInfoProvider.overrideWithValue(await PackageInfo.fromPlatform()),
        userModeStateProvider.overrideWith(
          (ref) => hostDocumentExists ? UserMode.host : UserMode.worker,
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'MOTTAI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        sliderTheme: SliderThemeData(
          overlayShape: SliderComponentShape.noOverlay,
        ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              elevation: 4,
              shadowColor: Theme.of(context).shadowColor,
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: const DevelopmentItemsPage(),
      builder: (context, child) {
        return ScaffoldMessenger(
          key: ref.watch(scaffoldMessengerKeyProvider),
          child: child!,
        );
      },
    );
  }
}
