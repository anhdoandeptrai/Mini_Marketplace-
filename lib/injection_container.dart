import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/course_remote_datasource.dart';
import 'data/datasources/imgbb_remote_datasource.dart';
import 'data/datasources/order_remote_datasource.dart';
import 'data/datasources/chat_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/course_repository_impl.dart';
import 'data/repositories/order_repository_impl.dart';
import 'data/repositories/chat_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/course_repository.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/repositories/chat_repository.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/auth/register_usecase.dart';
import 'domain/usecases/auth/logout_usecase.dart';
import 'domain/usecases/auth/get_current_user_usecase.dart';
import 'domain/usecases/course/get_courses_usecase.dart';
import 'domain/usecases/course/get_course_by_id_usecase.dart';
import 'domain/usecases/course/create_course_usecase.dart';
import 'domain/usecases/course/get_my_courses_usecase.dart';
import 'domain/usecases/course/toggle_course_status_usecase.dart';
import 'domain/usecases/course/update_course_usecase.dart';
import 'domain/usecases/course/delete_course_usecase.dart';
import 'domain/usecases/order/create_order_usecase.dart';
import 'domain/usecases/order/get_my_orders_usecase.dart';
import 'domain/usecases/chat/send_message_usecase.dart';
import 'domain/usecases/chat/get_messages_usecase.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/course/course_bloc.dart';
import 'presentation/blocs/order/order_bloc.dart';
import 'presentation/blocs/chat/chat_bloc.dart';
import 'presentation/blocs/language/language_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // -----------------------------
  // Optional imgbb configuration
  // WARNING: Storing API keys in code is insecure. For demo/testing only.
  const bool USE_IMGBB = true;
  const String IMGBB_API_KEY = 'b3b4eb0f7c35aa1db45bbf3f17d5e01c';
  // -----------------------------
  // BLoCs
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => CourseBloc(
      getCoursesUseCase: sl(),
      createCourseUseCase: sl(),
      getMyCoursesUseCase: sl(),
      toggleCourseStatusUseCase: sl(),
      updateCourseUseCase: sl(),
      deleteCourseUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => OrderBloc(createOrderUseCase: sl(), getMyOrdersUseCase: sl()),
  );

  sl.registerFactory(
    () => ChatBloc(sendMessageUseCase: sl(), getMessagesUseCase: sl()),
  );

  sl.registerFactory(() => LanguageCubit(sharedPreferences: sl()));

  // Use Cases - Auth
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  // Use Cases - Course
  sl.registerLazySingleton(() => GetCoursesUseCase(sl()));
  sl.registerLazySingleton(() => GetCourseByIdUseCase(sl()));
  sl.registerLazySingleton(() => CreateCourseUseCase(sl()));
  sl.registerLazySingleton(() => GetMyCoursesUseCase(sl()));
  sl.registerLazySingleton(() => ToggleCourseStatusUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCourseUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCourseUseCase(sl()));

  // Use Cases - Order
  sl.registerLazySingleton(() => CreateOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetMyOrdersUseCase(sl()));

  // Use Cases - Chat
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );

  final ImgbbRemoteDataSource? _imgbb = USE_IMGBB
      ? ImgbbRemoteDataSourceImpl(apiKey: IMGBB_API_KEY)
      // ignore: dead_code
      : null;

  sl.registerLazySingleton<CourseRemoteDataSource>(
    () => CourseRemoteDataSourceImpl(
      firestore: sl(),
      storage: sl(),
      imgbbRemote: _imgbb,
      useImgbbOnCreate: USE_IMGBB,
    ),
  );

  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(firestore: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}
