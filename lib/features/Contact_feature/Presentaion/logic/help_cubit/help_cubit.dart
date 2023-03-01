import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/ues_cases/help_ues_cases.dart';
import 'help_states.dart';

class HelpCubit extends Cubit<HelpStates> {
  final HelpUesCases useCase;

  HelpCubit(this.useCase) : super(HelpInitState());

  static HelpCubit get(context) => BlocProvider.of(context);


  addContact({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,

  }) async {
    emit(HelpAddContactLoadingState());
    var result = await useCase.addContact(
        name: name,
        email: email,
        phone: phone,
        subject: subject,
        message: message,
      );
    result.fold((error) => emit(HelpAddContactFailState(error)),
        (success) => emit(HelpAddContactSuccessState()));
  }

}
