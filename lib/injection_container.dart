import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/network/network_info.dart';
import 'package:todo_app/features/authentecation/data/datasources/auth_remote_data_source.dart';
import 'package:todo_app/features/authentecation/data/repositories/auth_repository_impl.dart';
import 'package:todo_app/features/authentecation/domain/repositories/auth_repository.dart';
import 'package:todo_app/features/authentecation/domain/usecases/check_user_auth.dart';
import 'package:todo_app/features/authentecation/domain/usecases/create_user.dart';
import 'package:todo_app/features/authentecation/domain/usecases/login_user.dart';
import 'package:todo_app/features/authentecation/domain/usecases/logout_user.dart';
import 'package:todo_app/features/authentecation/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:todo_app/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/use_cases/add_task.dart';
import 'package:todo_app/features/tasks/domain/use_cases/delete_task.dart';
import 'package:todo_app/features/tasks/domain/use_cases/get_all_tasks.dart';
import 'package:todo_app/features/tasks/domain/use_cases/update_checkbox.dart';
import 'package:todo_app/features/tasks/domain/use_cases/update_task.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/add_delete_update_tasks/add_delete_update_tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/task/tasks_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth

  //Bloc
  sl.registerFactory(
    () => AuthBloc(
        createUserUsecase: sl(),
        loginUserUsecase: sl(),
        checkUserUsecase: sl(),
        logoutUserUsecase: sl()),
  );
  //Usecases
  sl.registerLazySingleton(() => CreateUserUsecase(sl()));
  sl.registerLazySingleton(() => LoginUserUsecase(sl()));
  sl.registerLazySingleton(() => CheckUserUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUserUsecase(sl()));

  //Repository
  sl.registerLazySingleton<AuthRepositories>(() => AuthRepositoryImpl(
      networkInfo: sl<NetworkInfo>(), authRemoteDataSource: sl()));
  //DataSources

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<Account>(), sl()));

  //! Features - Tasks

  //Bloc
  sl.registerFactory(() => TasksBloc(
        getAllTasksUsecases: sl(),
        updateCheckbox: sl(),
      ));
  sl.registerFactory(
    () => AddDeleteUpdateTasksBloc(
      addTask: sl(),
      updateTask: sl(),
      deleteTask: sl(),
      //updateCheckbox: sl()
    ),
  );

  //Usecases
  sl.registerLazySingleton(() => AddTaskUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTasksUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCheckboxUsecase(sl()));

  //Repository
  sl.registerLazySingleton<TasksRepository>(() => TaskRepositoryImpl(
      taskRemoteDataSource: sl(),
      taskLocalDataSource: sl(),
      networkInfo: sl())); //ما فيني اخد اوبجيكت من الابستراكت كلاس

  //DataSources
  sl.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(sl()));

  //!Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() =>
      sharedPreferences); // انا هون دايما بقلب الاقواس بعمل ارجاع لاوبجيكت من الكلاس
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Account(client));
}
