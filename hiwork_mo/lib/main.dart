import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'firebase_options.dart';
import 'package:hiwork_mo/core/injection/dependency_injection.dart' as di;
import 'package:hiwork_mo/l10n/app_localizations.dart';

import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_event.dart';
import 'package:hiwork_mo/presentation/bloc/language/language_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/language/language_state.dart';
import 'package:hiwork_mo/presentation/bloc/notification/notification_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/timesheet/timesheet_bloc.dart';

import 'package:hiwork_mo/presentation/bloc/leave/leave_bloc.dart';

// Import Route
import 'package:hiwork_mo/presentation/route/app_route.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔥 BẮT BUỘC: Khởi tạo Firebase trước khi dùng FirebaseAuth
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Khởi tạo DI
  await di.configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LanguageBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>()..add(AppStarted()),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => di.sl<NotificationBloc>(),
        ),
        BlocProvider<TimesheetBloc>(
          create: (context) => di.sl<TimesheetBloc>(),
        ),
        BlocProvider<LeaveBloc>(
          create: (context) => di.sl<LeaveBloc>(),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'HiWork',
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.backgroundColor,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoute.splash,
            onGenerateRoute: AppRoute.generateRoute,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('vi'),
            ],
            locale: state.locale,
          );
        },
      ),
    );
  }
}
