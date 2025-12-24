import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/domain/usecases/upload_register_image_usecase.dart';
import '../../../domain/usecases/update_personal_info_usecase.dart';
import 'employee_personal_edit_event.dart';
import 'employee_personal_edit_state.dart';

class EmployeePersonalEditBloc
    extends Bloc<EmployeePersonalEditEvent, EmployeePersonalEditState> {
  final UpdatePersonalInfoUseCase updatePersonalInfoUseCase;
  final UploadRegisterImageUseCase uploadUseCase;

  EmployeePersonalEditBloc({required this.updatePersonalInfoUseCase, required this.uploadUseCase})
    : super(const EmployeePersonalEditState()) {
    on<EmployeePersonalEditSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    EmployeePersonalEditSubmitted event,
    Emitter<EmployeePersonalEditState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, error: null));
    try {
      // String? imageUrl;
      // if (event.pickedImagePath != null && event.pickedImagePath!.isNotEmpty) {
      //   imageUrl = await uploadUseCase(id: event.id, filePath: event.pickedImagePath!);
      // }

      await updatePersonalInfoUseCase(
        id: event.id,
        name: event.name,
        address: event.address,
        gender: event.gender,
        dob: event.dob,
        imageCheckUrl: event.pickedImagePath,
        phone: event.phone,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
