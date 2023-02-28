
import 'package:captien_omda_customer/core/form_builder_feature/domain/model/form_builder_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/model/form_option_model.dart';
import '../../domain/uesCaes/form_builder_use_caes.dart';
import 'form_builder_state.dart';

class FormBuilderCubit extends Cubit<FormBuilderState> {
  FormBuilderCubit(this._productUesCases)
      : super(FormBuilderProductInitialState());
  final FormBuilderUesCases _productUesCases;
  List<FormBuilderModel> formList = [];

  updateView() {
    emit(FormBuilderProductInitialState());
  }

  getProductForm({required int categoryId}) async {
    emit(GetCategoryFormLoadingStates());
    var result =
        await _productUesCases.callCategoryForm(categoryId: categoryId);

    result.fold((failure) => emit(GetCategoryFormErrorStates(failure)),
        (requestData) {
      formList = [];
      formList = requestData;

      emit(GetCategoryFormSuccessStates());
    });
  }

  getProductFilterForm({required int categoryId}) async {
    emit(GetCategoryFormLoadingStates());
    var result =
        await _productUesCases.callCategoryFilterForm(categoryId: categoryId);

    result.fold((failure) => emit(GetCategoryFormErrorStates(failure)),
        (requestData) {
      formList.clear();
      formList = requestData;
      emit(GetCategoryFormSuccessStates());
    });
  }

  createNewFiledFromOption(
      FormBuilderModel parentModel, FormOptionModel childOption,
      {FormOptionModel? oldChild}) {
    if (oldChild != null) {
      formList.removeWhere((element) => element.parentId == oldChild.id);
    }
    formList.add(parentModel.copyWith(childOption));
    emit(FormBuilderProductInitialState());
  }
}
