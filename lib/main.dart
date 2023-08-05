import 'package:amazon_clone/bindings.dart';
import 'package:amazon_clone/common/widgets/botton_bar.dart';
import 'package:amazon_clone/constants/global_varaiables.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/providers/user_provider_getx.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (context) => UserProvider(),
    //     ),
    //   ],
    //   child: const MyApp(),
    // ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final AuthService authService = AuthService();

  // @override
  // void initState() {
  //   super.initState();
  //   authService.getUserData(context: context);
  // }

  @override
  Widget build(BuildContext context) {
    final UserController _userController = Get.put(UserController());
    return GetMaterialApp(
      initialBinding: AppBindings(),
      title: 'Material App',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        primaryColor: GlobalVariables.secondaryColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) {
        return generateRoute(settings);
      },
      home:
          // Provider.of<UserProvider>(context).user.token.isNotEmpty
          _userController.user.token.isNotEmpty
              ? const BottonBar()
              : const AuthScreen(),
    );
  }
}
