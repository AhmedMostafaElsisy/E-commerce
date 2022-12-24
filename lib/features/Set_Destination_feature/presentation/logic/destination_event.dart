import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/location_model.dart';
import 'package:equatable/equatable.dart';

class SearchEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchClickEvent extends SearchEvents {
  final String? text;

  SearchClickEvent(
    this.text,
  );
}

class SetDestinationEvent extends SearchEvents {
  final LocationModel model;
  final bool isFromLocation;

  SetDestinationEvent(this.model, this.isFromLocation);
}
