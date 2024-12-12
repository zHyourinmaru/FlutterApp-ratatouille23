import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ratatouille23/src/constants/localization.dart';
import 'package:ratatouille23/src/view_models/allergen_view_model.dart';
import 'package:ratatouille23/src/view_models/authenticate_view_model.dart';
import 'package:ratatouille23/src/view_models/dish_view_model.dart';
import 'package:ratatouille23/src/view_models/order_view_model.dart';
import 'package:ratatouille23/src/view_models/table_view_model.dart';
import 'package:ratatouille23/src/view_models/user_view_model.dart';
import 'firebase_options.dart';
import 'src/constants/theme.dart';
import 'src/features/intro.dart';
import 'src/features/home.dart';
import 'src/features/authentication/login.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  // Set landscape orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Ratatouille23());
}

class Ratatouille23 extends StatelessWidget {
  const Ratatouille23({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => AuthenticateViewModel()),
        ChangeNotifierProvider(create: (_) => TableViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => AllergenViewModel()),
        ChangeNotifierProvider(create: (_) => DishViewModel()),
      ],
      child: GetMaterialApp(
          translations: LocaleString(),
          locale: const Locale('it', 'IT'),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          title: 'Ratatouille23',
          initialRoute: '/intro',
          routes: {
            '/intro': (context) => const Intro(),
            '/login': (context) => const Login(),
            '/home': (context) => const Home(),
          }),
    );
  }
}
