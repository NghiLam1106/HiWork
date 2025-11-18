import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  // --- 1. SỬA LỖI Ở ĐÂY (Thêm dấu ? sau Object) ---
  List<Object?> get props => [];
}

// Trạng thái ban đầu (Chưa xác định)
class AuthInitial extends AuthState {}

// Trạng thái: Đang tải hoặc xử lý
class AuthLoading extends AuthState {}

// Trạng thái: Đã xác thực và có thông tin người dùng
class Authenticated extends AuthState {
  final UserEntity user;
  const Authenticated({required this.user});

  @override
  // --- 2. SỬA LỖI Ở ĐÂY (Thêm dấu ? sau Object) ---
  List<Object?> get props => [user];
}

// Trạng thái: Chưa xác thực
class Unauthenticated extends AuthState {}

// Trạng thái: Lỗi
class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  // --- 3. SỬA LỖI Ở ĐÂY (Thêm dấu ? sau Object) ---
  List<Object?> get props => [message];
}