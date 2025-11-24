import 'package:dartz/dartz.dart';
import '../entities/attendance_entity.dart';
import '../../data/repositories/attendance_repository_impl.dart';

class SubmitUseCase {
  // Thay thế bằng Repository Interface thực tế
  final AttendanceCorrectionRepositoryImpl repository;

  SubmitUseCase({required this.repository});

  // Hàm thực thi: nhận Entity và trả về Either<String, bool>
  Future<Either<String, bool>> call({required AttendanceEntity correctionData}) async {
    // 1. Kiểm tra các điều kiện logic nghiệp vụ (ví dụ: giờ Check-in phải trước giờ Check-out)
    if (correctionData.newCheckIn != null && 
        correctionData.newCheckOut != null &&
        correctionData.newCheckIn!.isAfter(correctionData.newCheckOut!)) {
      return const Left('Giờ Check-in không thể sau giờ Check-out.');
    }

    // 2. Kiểm tra lý do
    if (correctionData.note.trim().isEmpty) {
      return const Left('Vui lòng cung cấp lý do sửa đổi.');
    }

    // 3. Gọi Repository để gửi yêu cầu
    return await repository.submitCorrection(
            correctionData: correctionData, 
      );
  }
}