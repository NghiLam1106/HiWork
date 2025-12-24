import 'package:dio/dio.dart';
import 'package:hiwork_mo/core/constants/api_endpoints.dart';
import 'package:get_it/get_it.dart';
import 'package:hiwork_mo/core/dio/dioClient.dart';

import 'package:hiwork_mo/data/datasources/attendance_scan_remote_datasource.dart';
import 'package:hiwork_mo/data/datasources/auth_remote_datasource.dart';
import 'package:hiwork_mo/data/datasources/employee_detail_remote_datasource.dart';
import 'package:hiwork_mo/data/datasources/employee_detail_remote_datasource_impl.dart';
import 'package:hiwork_mo/data/local/employee_detail_storage.dart';
import 'package:hiwork_mo/data/models/employee_detail_model.dart';

import 'package:hiwork_mo/data/repositories/attendance_scan_repository_impl.dart';
import 'package:hiwork_mo/data/repositories/auth_repository_impl.dart';
import 'package:hiwork_mo/data/repositories/employee_detail_repository_impl.dart';

import 'package:hiwork_mo/domain/repositories/attendance_scan_repository.dart';
import 'package:hiwork_mo/domain/repositories/auth_repository.dart';
import 'package:hiwork_mo/domain/repositories/employee_detail_repository.dart';

import 'package:hiwork_mo/domain/usecases/check_in_with_face_usecase.dart';
import 'package:hiwork_mo/domain/usecases/check_out_usecase.dart';
import 'package:hiwork_mo/domain/usecases/get_shifts_detail_usecase.dart';
import 'package:hiwork_mo/domain/usecases/login_usecase.dart';
import 'package:hiwork_mo/domain/usecases/register_usecase.dart';
import 'package:hiwork_mo/domain/usecases/get_employee_detail_usecase.dart'; // ✅ thêm
import 'package:hiwork_mo/domain/usecases/update_personal_info_usecase.dart';
import 'package:hiwork_mo/domain/usecases/upload_register_image_usecase.dart';

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

import 'package:hiwork_mo/presentation/bloc/employee_detail/employee_detail_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/employee_personal_edit/employee_personal_edit_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Dio
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    ),
  );

  // ✅ DioClient (nếu bạn dùng ở nơi khác; không dùng cũng không sao)
  sl.registerLazySingleton<DioClient>(() => DioClient(sl<Dio>()));

  // --- AUTH ---
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

  // --- NOTIFICATION ---
  sl.registerFactory(() => NotificationBloc(getNotificationsUseCase: sl()));
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl<NotificationRepository>()));
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(),
  );

  // --- TIMESHEET ---
  sl.registerFactory(() => TimesheetBloc(getWeeklyTimesheetUseCase: sl()));
  sl.registerLazySingleton(() => GetWeeklyTimesheetUseCase(sl<TimesheetRepository>()));
  sl.registerLazySingleton<TimesheetRepository>(
    () => TimesheetRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TimesheetRemoteDataSource>(
    () => TimesheetRemoteDataSourceImpl(),
  );

  // --- LEAVE ---
  sl.registerFactory(
    () => LeaveBloc(
      getLeaveBalanceUseCase: sl(),
      getLeaveHistoryUseCase: sl(),
      submitLeaveUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetLeaveBalanceUseCase(sl<LeaveRepository>()));
  sl.registerLazySingleton(() => GetLeaveHistoryUseCase(sl<LeaveRepository>()));
  sl.registerLazySingleton(() => SubmitLeaveUseCase(sl<LeaveRepository>()));
  sl.registerLazySingleton<LeaveRepository>(
    () => LeaveRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LeaveRemoteDataSource>(
    () => LeaveRemoteDataSourceImpl(),
  );

  // --- ATTENDANCE SCAN ---
  sl.registerLazySingleton<AttendanceScanRemoteDataSource>(
    () => AttendanceScanRemoteDataSourceImpl(sl<DioClient>()),
  );
  sl.registerLazySingleton<AttendanceScanRepository>(
    () => AttendanceScanRepositoryImpl(sl<AttendanceScanRemoteDataSource>()),
  );
  sl.registerLazySingleton(() => GetShiftsDetailUsecase(sl<AttendanceScanRepository>()));
  sl.registerLazySingleton(() => CheckInWithFaceUsecase(sl<AttendanceScanRepository>()));
  sl.registerLazySingleton(() => CheckOutUsecase(sl<AttendanceScanRepository>()));
  sl.registerFactory(
    () => AttendanceScanBloc(
      getShiftsUsecase: sl(),
      checkInWithFaceUsecase: sl(),
      checkOutUsecase: sl(),
    ),
  );

  // --- EMPLOYEE DETAIL / EDIT PERSONAL ---

  // ✅ 1) Storage phải register trước
  sl.registerLazySingleton<EmployeeDetailStorage>(() => EmployeeDetailStorage());

  // ✅ 2) DataSource: constructor chỉ nhận storage
  sl.registerLazySingleton<EmployeeDetailRemoteDataSource>(
    () => EmployeeDetailRemoteDataSourceImpl(sl<EmployeeDetailStorage>(), sl<DioClient>()),
  );

  // ✅ 3) Repository
  sl.registerLazySingleton<EmployeeDetailRepository>(
    () => EmployeeDetailRepositoryImpl(remote: sl()),
  );

  // ✅ 4) UseCase lấy detail (bạn đang thiếu nên bloc sẽ lỗi)
  sl.registerLazySingleton(() => GetEmployeeDetailUseCase(sl<EmployeeDetailRepository>()));

  // UseCases edit
  sl.registerLazySingleton(() => UpdatePersonalInfoUseCase(sl<EmployeeDetailRepository>()));
  sl.registerLazySingleton(() => UploadRegisterImageUseCase(sl<EmployeeDetailRepository>()));

  // Blocs
  sl.registerFactory(
    () => EmployeePersonalEditBloc(
      updatePersonalInfoUseCase: sl(),
      uploadUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => EmployeeDetailBloc(getEmployeeDetailUseCase: sl()),
  );
}
