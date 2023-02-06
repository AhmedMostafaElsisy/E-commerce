import 'package:flutter/material.dart';

import '../../domain/model/location_area_model.dart';
import '../../domain/uesCaes/location_use_caes.dart';
import 'pick_location_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickLocationCubit extends Cubit<PickLocationStates> {
  PickLocationCubit(this._locationUesCases) : super(PickLocationInitStates());

  static PickLocationCubit get(context) => BlocProvider.of(context);
  final LocationUesCases _locationUesCases;

  ///City list data
  List<LocationAreaModel> cityList = [];
  List<LocationAreaModel> tempCityList = [];
  LocationAreaModel? selectedCity;

  ///pagination
  int cityPageNumber = 1;
  late ScrollController cityScrollController;
  bool cityHasMoreData = false;

  ///area list data
  List<LocationAreaModel> areaList = [];
  List<LocationAreaModel> tempAreaList = [];
  LocationAreaModel? selectedArea;

  int areaPageNumber = 1;
  late ScrollController areaScrollController;
  bool areaHasMoreData = false;

  ///search in city list by name
  searchInCityList(String value) {
    tempCityList = cityList
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    emit(FilterSearchState());
  }

  ///get city data
  getCityData({required countyId}) async {
    emit(CityLocationLoadingState());
    cityPageNumber = 1;
    var result = await _locationUesCases.callCityList(
        page: cityPageNumber, countryId: countyId);

    result.fold(
      (failure) => emit(CityLocationFailedState(failure)),
      (cityData) {
        if (cityData.isEmpty) {
          emit(CityLocationEmptyState());
        } else {
          cityHasMoreData = cityData.length == 10;
          cityList = cityData;
          tempCityList = cityData;

          emit(CityLocationSuccessState());
        }
      },
    );
  }

  void setupCityScrollController({required countyId}) {
    if (cityScrollController.offset >
            cityScrollController.position.maxScrollExtent - 200 &&
        cityScrollController.offset >=
            cityScrollController.position.maxScrollExtent) {
      if (state is! CityLocationLoadingMoreDataState && cityHasMoreData) {
        whenScrollCountryPagination(countyId: countyId);
      }
    }
  }

  ///get category pagination
  whenScrollCountryPagination({required countyId}) async {
    emit(CityLocationLoadingMoreDataState());
    cityPageNumber = cityPageNumber + 1;
    var result = await _locationUesCases.callCityList(
        page: cityPageNumber, countryId: countyId);

    result.fold(
      (failure) => emit(CityLocationFailedMoreDataState(failure)),
      (countryData) {
        cityHasMoreData = countryData.length == 10;
        cityList.addAll(countryData);
        tempCityList.addAll(countryData);
        emit(CityLocationSuccessState());
      },
    );
  }

  ///search in country list by name
  searchInAreaList(String value) {
    tempAreaList = areaList
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    emit(FilterSearchState());
  }

  ///get area data
  getAreaData({required int cityID}) async {
    emit(AreaLocationLoadingState());
    areaPageNumber = 1;
    var result = await _locationUesCases.callAreaList(
        page: areaPageNumber, cityId: cityID);

    result.fold(
      (failure) => emit(AreaLocationFailedState(failure)),
      (areaData) {
        if (areaData.isEmpty) {
          emit(AreaLocationEmptyState());
        } else {
          areaHasMoreData = areaData.length == 10;
          areaList = areaData;
          tempAreaList = areaData;

          emit(AreaLocationSuccessState());
        }
      },
    );
  }

  void setupAreaScrollController({required int countryID}) {
    if (areaScrollController.offset >
            areaScrollController.position.maxScrollExtent - 200 &&
        areaScrollController.offset >=
            areaScrollController.position.maxScrollExtent) {
      if (state is! AreaLocationLoadingMoreDataState && areaHasMoreData) {
        whenScrollAreaPagination(cityID: countryID);
      }
    }
  }

  ///get area pagination
  whenScrollAreaPagination({required int cityID}) async {
    emit(AreaLocationLoadingMoreDataState());
    areaPageNumber = areaPageNumber + 1;
    var result = await _locationUesCases.callAreaList(
        page: areaPageNumber, cityId: cityID);

    result.fold(
      (failure) => emit(AreaLocationFailedMoreDataState(failure)),
      (areaData) {
        areaHasMoreData = areaData.length == 10;
        areaList.addAll(areaData);
        tempAreaList.addAll(areaData);
        emit(AreaLocationSuccessState());
      },
    );
  }
}
