import 'package:dio/dio.dart';
import 'package:hiwork_mo/core/constants/api_endpoints.dart';
import 'package:get_it/get_it.dart';
import 'package:hiwork_mo/data/datasources/attendance_scan_remote_datasource.dart';
import 'package:hiwork_mo/data/datasources/auth_remote_datasource.dart';
import 'package:hiwork_mo/data/repositories/attendance_scan_repository_impl.dart';
import 'package:hiwork_mo/data/repositories/auth_repository_impl.dart';
import 'package:hiwork_mo/domain/repositories/attendance_scan_repository.dart';
import 'package:hiwork_mo/domain/repositories/auth_repository.dart';
import 'package:hiwork_mo/domain/usecases/check_in_with_face_usecase.dart';
import 'package:hiwork_mo/domain/usecases/check_out_usecase.dart';
import 'package:hiwork_mo/domain/usecases/get_shifts_detail_usecase.dart';
import 'package:hiwork_mo/domain/usecases/login_usecase.dart';
import 'package:hiwork_mo/domain/usecases/register_usecase.dart';
import 'package:hiwork_mo/presentation/bloc/attendanceScan/attendance_scan_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/data/datasources/notification_remote_datasource.dart';
import 'package:hiwork_mo/data/repositories/notification_repository_impl.dart';
import 'package:hiwork_mo/domain/repositories/notification_repository.dart';
import 'package:hiwork_mo/domain/usecases/get_notifications_usecase.dart';
import 'package:hiwork_mo/presentation/bloc/notification/notification_bloc.dart';
import 'package:hiwork_mo/data/datasources/timesheet_remote_datasource.dart';
import 'package:hiwork_mo/data/repositories/timesheet_repository_impl.dart';
import 'package:hiwork_mo/domain/repositories/timesheet_repository.dart';
import 'package:hiwork_mo/domain/usecases/get_weekly_timesheet_usecase.dart';
import 'package:hiwork_mo/presentation/bloc/timesheet/timesheet_bloc.dart';
import 'package:hiwork_mo/data/datasources/leave_remote_datasource.dart';
import 'package:hiwork_mo/data/repositories/leave_repository_impl.dart';
import 'package:hiwork_mo/domain/repositories/leave_repository.dart';
import 'package:hiwork_mo/domain/usecases/get_leave_balance_usecase.dart';
import 'package:hiwork_mo/domain/usecases/get_leave_history_usecase.dart';
import 'package:hiwork_mo/domain/usecases/submit_leave_request_usecase.dart';
import 'package:hiwork_mo/presentation/bloc/leave/leave_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    ),
  );

  // --- TÍNH NĂNG AUTH (XÁC THỰC) ---
  sl.registerFactory(
    () => AuthBloc(
      logInUseCase: sl(),
      registerUseCase: sl(),
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton(() => LogInUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // --- TÍNH NĂNG NOTIFICATION ---
  sl.registerFactory(
    () => NotificationBloc(
      getNotificationsUseCase:
          sl(), // Đảm bảo đã thêm 'getNotificationsUseCase'
    ),
  );
  sl.registerLazySingleton(
    () => GetNotificationsUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(),
  );

  // --- TÍNH NĂNG TIMESHEET (BẢNG CHẤM CÔNG) ---
  sl.registerFactory(() => TimesheetBloc(getWeeklyTimesheetUseCase: sl()));
  sl.registerLazySingleton(
    () => GetWeeklyTimesheetUseCase(sl<TimesheetRepository>()),
  );
  sl.registerLazySingleton<TimesheetRepository>(
    () => TimesheetRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TimesheetRemoteDataSource>(
    () => TimesheetRemoteDataSourceImpl(),
  );
  // --- (Kết thúc Timesheet) ---

  // --- TÍNH NĂNG LEAVE (ĐĂNG KÝ NGHỈ) ---
  sl.registerFactory(
    () => LeaveBloc(
      getLeaveBalanceUseCase: sl(),
      getLeaveHistoryUseCase: sl(),
      submitLeaveUseCase: sl(),
    ),
  );
  // UseCases
  sl.registerLazySingleton(() => GetLeaveBalanceUseCase(sl<LeaveRepository>()));
  sl.registerLazySingleton(() => GetLeaveHistoryUseCase(sl<LeaveRepository>()));
  sl.registerLazySingleton(() => SubmitLeaveUseCase(sl<LeaveRepository>()));

  // Repository
  sl.registerLazySingleton<LeaveRepository>(
    () => LeaveRepositoryImpl(remoteDataSource: sl()),
  );

  // DataSource
  sl.registerLazySingleton<LeaveRemoteDataSource>(
    () => LeaveRemoteDataSourceImpl(),
  );
  // --- (Kết thúc Leave) ---

  // --- TÍNH NĂNG ATTENDANCE SCAN (CHECK-IN/OUT) ---

  // DataSource
  sl.registerLazySingleton<AttendanceScanRemoteDataSource>(
    () => AttendanceScanRemoteDataSourceImpl(sl<Dio>()),
  );

  // Repository
  sl.registerLazySingleton<AttendanceScanRepository>(
    () => AttendanceScanRepositoryImpl(sl<AttendanceScanRemoteDataSource>()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetShiftsDetailUsecase(sl<AttendanceScanRepository>()));
  sl.registerLazySingleton(
    () => CheckInWithFaceUsecase(sl<AttendanceScanRepository>()),
  );
  sl.registerLazySingleton(
    () => CheckOutUsecase(sl<AttendanceScanRepository>()),
  );

  // Bloc
  sl.registerFactory(
    () => AttendanceScanBloc(
      getShiftsUsecase: sl(),
      checkInWithFaceUsecase: sl(),
      checkOutUsecase: sl(),
    ),
  );
}
