import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/core/services/socket_service.dart';
import 'package:esl/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:esl/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:esl/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:esl/features/auth/domain/repositories/auth_repository.dart';
import 'package:esl/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:esl/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:esl/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:esl/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:esl/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/gallery/data/datasources/gallery_remote_datasource.dart';
import 'package:esl/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:esl/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:esl/features/gallery/domain/usecases/get_gallery_usecase.dart';
import 'package:esl/features/gallery/presentation/blocs/gallery_bloc.dart';
import 'package:esl/features/home/data/datasources/announcment_remote_datasource.dart';
import 'package:esl/features/home/data/datasources/event_remote_datasource.dart';
import 'package:esl/features/home/data/datasources/feedback_remote_datasource.dart';
import 'package:esl/features/home/data/datasources/hero_remote_datasource.dart';
import 'package:esl/features/home/data/datasources/news_remote_datasource.dart';
import 'package:esl/features/home/data/repositories/announcment_repository_impl.dart';
import 'package:esl/features/home/data/repositories/event_repository_impl.dart';
import 'package:esl/features/home/data/repositories/feedback_repository_impl.dart';
import 'package:esl/features/home/data/repositories/hero_repository_impl.dart';
import 'package:esl/features/home/data/repositories/news_repository_impl.dart';
import 'package:esl/features/home/domain/repositories/announcment_repository.dart';
import 'package:esl/features/home/domain/repositories/event_repository.dart';
import 'package:esl/features/home/domain/repositories/feedback_repository.dart';
import 'package:esl/features/home/domain/repositories/hero_repository.dart';
import 'package:esl/features/home/domain/repositories/news_repository.dart';
import 'package:esl/features/home/domain/usecases/get_announcments_usecase.dart';
import 'package:esl/features/home/domain/usecases/get_events_by_date_usecase.dart';
import 'package:esl/features/home/domain/usecases/get_heroes_usecase.dart';
import 'package:esl/features/home/domain/usecases/get_news_usecase.dart';
import 'package:esl/features/home/domain/usecases/submit_feedback_usecase.dart';
import 'package:esl/features/home/presentation/blocs/announcment/bloc/announcment_bloc.dart';
import 'package:esl/features/home/presentation/blocs/event/event_bloc.dart';
import 'package:esl/features/home/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:esl/features/home/presentation/blocs/hero/hero_bloc.dart';
import 'package:esl/features/home/presentation/blocs/news/news_bloc.dart';
import 'package:esl/features/library/data/datasources/resource_remote_datasource.dart';
import 'package:esl/features/library/data/repositories/resource_repository_impl.dart';
import 'package:esl/features/library/domain/repositories/resource_repository.dart';
import 'package:esl/features/library/domain/usecases/get_authors_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_library_news_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_resource_by_authors_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_resource_by_category_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_resource_by_department_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_resources_usecase.dart';
import 'package:esl/features/library/presentation/blocs/resource_bloc.dart';
import 'package:esl/features/my_course/data/datasources/application_remote_datasource.dart';
import 'package:esl/features/my_course/data/datasources/my_course_remote_datasource.dart';
import 'package:esl/features/my_course/data/repositories/application_repository_impl.dart';
import 'package:esl/features/my_course/data/repositories/my_course_repository_impl.dart';
import 'package:esl/features/my_course/domain/repositories/application_repository.dart';
import 'package:esl/features/my_course/domain/repositories/my_course_repository.dart';
import 'package:esl/features/my_course/domain/usecases/apply_usecase.dart';
import 'package:esl/features/my_course/domain/usecases/get_enrolled_program_usecase.dart';
import 'package:esl/features/my_course/domain/usecases/get_grade_usecase.dart';
import 'package:esl/features/my_course/domain/usecases/get_weekly_schedule_usecase.dart';
import 'package:esl/features/my_course/presentation/blocs/my_course/my_course_bloc.dart';
import 'package:esl/features/my_course/presentation/blocs/registration/registration_bloc.dart';
import 'package:esl/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:esl/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:esl/features/profile/domain/repositories/profile_repository.dart';
import 'package:esl/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:esl/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:esl/features/program/data/datasources/program_remote_datasource.dart';
import 'package:esl/features/program/data/repositories/program_repository_impl.dart';
import 'package:esl/features/program/domain/repositories/program_repository.dart';
import 'package:esl/features/program/domain/usecases/get_programs_usecase.dart';
import 'package:esl/features/program/presentation/blocs/program/program_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  //! Core Layer
  _initCore();

  //! Feature Layer - Auth
  _initAuthFeature();

  //! Feature Layer - Home
  _initHomeFeature();

  //! Feature Layer - Grade
  _initGradeFeature();

  //! Feature Layer - Program
  _initProgramFeature();

  //! Feature Layer - Library
  _initLibraryFeature();

  //! Feature Layer - Gallery
  _initGalleryFeature();

  //! Feature Layer - My Course
  _initMyCourseFeature();

  //! Feature Layer - Profile
  _initProfileFeature();
}

void _initCore() {
  // Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<SocketService>(() => SocketService());
}

void _initAuthFeature() {
  //* Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  //* Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //* Use Cases
  sl.registerFactory<CheckAuthUseCase>(() => CheckAuthUseCase(sl()));
  sl.registerFactory<LogInUseCase>(() => LogInUseCase(sl()));
  sl.registerFactory<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerFactory<LogOutUseCase>(() => LogOutUseCase(sl()));
  sl.registerFactory<RefreshTokenUseCase>(() => RefreshTokenUseCase(sl()));

  //* Presentation Layer
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      checkAuthUseCase: sl(),
      signInUseCase: sl(),
      signUpUseCase: sl(),
      logOutUseCase: sl(),
    ),
  );
}

void _initHomeFeature() {
  //* Data Sources
  sl.registerLazySingleton<EventRemoteDataSource>(
    () => EventRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<FeedbackRemoteDataSource>(
    () => FeedbackRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(dioClient: sl()),
  );
  sl.registerLazySingleton<HeroRemoteDataSource>(
    () => HeroRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AnnouncmentRemoteDataSource>(
    () => AnnouncmentRemoteDataSourceImpl(dioClient: sl()),
  );
  //* Repository
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(eventRemoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<FeedbackRepository>(
    () => FeedbackRepositoryImpl(
      feedbackRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<HeroRepository>(
    () => HeroRepositoryImpl(heroRemoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<AnnouncmentRepository>(
    () => AnnouncmentRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  //* Use Cases
  sl.registerFactory<GetNewsUseCase>(() => GetNewsUseCase(sl()));
  sl.registerFactory<GetEventsByDateUseCase>(
    () => GetEventsByDateUseCase(sl()),
  );
  sl.registerFactory<SubmitFeedbackUsecase>(() => SubmitFeedbackUsecase(sl()));
  sl.registerFactory<GetHeroesUsecase>(() => GetHeroesUsecase(sl()));
  sl.registerFactory<GetAnnouncmentsUsecase>(
    () => GetAnnouncmentsUsecase(sl()),
  );
  // sl.registerFactory<GetEventsByStatusUseCase>(() => GetEventsByStatusUseCase(sl()));
  // sl.registerFactory<GetEventsByTypeUseCase>(() => GetEventsByTypeUseCase(sl()));
  // sl.registerFactory<GetEventsByVisibilityUseCase>(() => GetEventsByVisibilityUseCase(sl()));

  //* Presentation Layer
  sl.registerLazySingleton<EventBloc>(
    () => EventBloc(getEventsByDateUseCase: sl()),
  );
  sl.registerLazySingleton<FeedbackBloc>(
    () => FeedbackBloc(submitFeedbackUsecase: sl()),
  );
  sl.registerLazySingleton<NewsBloc>(() => NewsBloc(getNewsUseCase: sl()));
  sl.registerLazySingleton<HeroBloc>(() => HeroBloc(getHeroesUsecase: sl()));
  sl.registerLazySingleton<AnnouncmentBloc>(
    () => AnnouncmentBloc(getAnnouncmentsUsecase: sl()),
  );
}

void _initGradeFeature() {
  //* Data Sources
  sl.registerLazySingleton<ApplicationRemoteDataSource>(
    () => ApplicationRemoteDataSourceImpl(dioClient: sl()),
  );

  //* Repository
  sl.registerLazySingleton<ApplicationRepository>(
    () => ApplicationRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  //* Use Cases
  sl.registerFactory<ApplyUseCase>(() => ApplyUseCase(sl()));

  //* Presentation Layer
  sl.registerLazySingleton<RegistrationBloc>(
    () => RegistrationBloc(applyUseCase: sl()),
  );
}

void _initProgramFeature() {
  //* Data Sources
  sl.registerLazySingleton<ProgramRemoteDataSource>(
    () => ProgramRemoteDataSourceImpl(dioClient: sl()),
  );

  //* Repository
  sl.registerLazySingleton<ProgramRepository>(
    () => ProgramRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  //* Use Cases
  sl.registerFactory<GetProgramsUseCase>(() => GetProgramsUseCase(sl()));

  //* Presentation Layer
  sl.registerLazySingleton<ProgramBloc>(
    () => ProgramBloc(getProgramsUseCase: sl()),
  );
}

void _initLibraryFeature() {
  //* Data Sources
  sl.registerLazySingleton<ResourceRemoteDataSource>(
    () => ResourceRemoteDataSourceImpl(dioClient: sl()),
  );

  //* Repository
  sl.registerLazySingleton<ResourceRepository>(
    () => ResourceRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  //* Use Cases
  sl.registerFactory<GetResourcesUseCase>(() => GetResourcesUseCase(sl()));
  sl.registerFactory<GetAuthorsUseCase>(() => GetAuthorsUseCase(sl()));
  sl.registerFactory<GetResourceByCategoryUseCase>(
    () => GetResourceByCategoryUseCase(sl()),
  );
  sl.registerFactory<GetResourceByAuthorsUseCase>(
    () => GetResourceByAuthorsUseCase(sl()),
  );
  sl.registerFactory<GetResourceByDepartmentUseCase>(
    () => GetResourceByDepartmentUseCase(sl()),
  );
  sl.registerFactory<GetLibraryNewsUseCase>(() => GetLibraryNewsUseCase(sl()));

  //* Presentation Layer
  sl.registerLazySingleton<ResourceBloc>(
    () => ResourceBloc(
      getResourcesUseCase: sl(),
      getAuthorsUseCase: sl(),
      getResourceByCategoryUseCase: sl(),
      getResourceByAuthorsUseCase: sl(),
      getResourceByDepartmentUseCase: sl(),
      getLibraryNewsUseCase: sl(),
    ),
  );
}

void _initGalleryFeature() {
  //* Data Sources
  sl.registerLazySingleton<GalleryRemoteDataSource>(
    () => GalleryRemoteDataSourceImpl(dioClient: sl()),
  );

  //* Repository
  sl.registerLazySingleton<GalleryRepository>(
    () => GalleryRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  //* Use Cases
  sl.registerFactory<GetGalleryUseCase>(() => GetGalleryUseCase(sl()));

  //* Presentation Layer
  sl.registerLazySingleton<GalleryBloc>(
    () => GalleryBloc(getGalleryUseCase: sl()),
  );
}

void _initMyCourseFeature() {
  //* Data Sources
  sl.registerLazySingleton<MyCourseRemoteDataSource>(
    () => MyCourseRemoteDataSourceImpl(dioClient: sl()),
  );

  //* Repository
  sl.registerLazySingleton<MyCourseRepository>(
    () => MyCourseRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  //* Use Cases
  sl.registerFactory<GetGradeUseCase>(() => GetGradeUseCase(sl()));
  sl.registerFactory<GetWeeklyScheduleUseCase>(
    () => GetWeeklyScheduleUseCase(sl()),
  );
  sl.registerFactory<GetEnrolledProgramUseCase>(
    () => GetEnrolledProgramUseCase(sl()),
  );

  //* Presentation Layer
  sl.registerLazySingleton<MyCourseBloc>(
    () => MyCourseBloc(
      getGradeUseCase: sl(),
      getWeeklyScheduleUsecase: sl(),
      getEnrolledProgramUseCase: sl(),
    ),
  );
}

void _initProfileFeature() {
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerFactory<ChangePasswordUseCase>(() => ChangePasswordUseCase(sl()));

  sl.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(changePasswordUseCase: sl()),
  );
}
