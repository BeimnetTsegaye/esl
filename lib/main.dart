import 'package:esl/config/routes.dart';
import 'package:esl/core/bloc/app_bloc_observer.dart';
import 'package:esl/core/di/service_locator.dart';
import 'package:esl/core/services/socket_service.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/gallery/presentation/blocs/gallery_bloc.dart';
import 'package:esl/features/home/presentation/blocs/announcment/bloc/announcment_bloc.dart';
import 'package:esl/features/home/presentation/blocs/event/event_bloc.dart';
import 'package:esl/features/home/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:esl/features/home/presentation/blocs/hero/hero_bloc.dart';
import 'package:esl/features/home/presentation/blocs/news/news_bloc.dart';
import 'package:esl/features/library/presentation/blocs/resource_bloc.dart';
import 'package:esl/features/my_course/presentation/blocs/my_course/my_course_bloc.dart';
import 'package:esl/features/my_course/presentation/blocs/registration/registration_bloc.dart';
import 'package:esl/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:esl/features/program/presentation/blocs/program/program_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<EventBloc>(create: (_) => sl<EventBloc>()),
        BlocProvider<FeedbackBloc>(create: (_) => sl<FeedbackBloc>()),
        BlocProvider<RegistrationBloc>(create: (_) => sl<RegistrationBloc>()),
        BlocProvider<NewsBloc>(create: (_) => sl<NewsBloc>()),
        BlocProvider<ProgramBloc>(create: (_) => sl<ProgramBloc>()),
        BlocProvider<ResourceBloc>(create: (_) => sl<ResourceBloc>()),
        BlocProvider<GalleryBloc>(create: (_) => sl<GalleryBloc>()),
        BlocProvider<MyCourseBloc>(create: (_) => sl<MyCourseBloc>()),
        BlocProvider<ProfileBloc>(create: (_) => sl<ProfileBloc>()),
        BlocProvider<HeroBloc>(create: (_) => sl<HeroBloc>()),
        BlocProvider<AnnouncmentBloc>(create: (_) => sl<AnnouncmentBloc>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthCheckRequested());

    final socketService = sl<SocketService>();
    socketService.initSocket();
    socketService.connect();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: currentThemeNotifier,
      builder: (context, currentTheme, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnsupportedRoleLogout) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 5),
                ),
              );
            }
          },
          child: MaterialApp.router(
            title: 'ESL',
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return ColoredBox(
                color: currentTheme == lightMode
                    ? AppConstants.eslWhite
                    : AppConstants.eslGrey,
                child: SafeArea(child: child!),
              );
            },
            theme: currentTheme,
            routerConfig: router,
          ),
        );
      },
    );
  }
}
