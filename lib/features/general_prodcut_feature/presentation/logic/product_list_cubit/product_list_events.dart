import 'package:equatable/equatable.dart';

class SearchEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchClickEvent extends SearchEvents {
  SearchClickEvent();
}

class SearchClickWithNameEvent extends SearchEvents {
  final String? text;

  SearchClickWithNameEvent(
    this.text,
  );
}

class SearchClearEvent extends SearchEvents {
  SearchClearEvent();
}

class LoadMoreData extends SearchEvents {
  LoadMoreData();
}
