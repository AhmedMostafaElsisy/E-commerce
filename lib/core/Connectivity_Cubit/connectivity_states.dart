abstract class ConnectivityState {}

class AppInitialInternetState extends ConnectivityState {}

class InternetLoading extends ConnectivityState {}

class InternetConnected extends ConnectivityState {}

class GetInternetConnected extends ConnectivityState {}

class NoWifiOrDataInternetConnected extends ConnectivityState {}

class InternetDisconnected extends ConnectivityState {}

class CancelSubscriptionInternet extends ConnectivityState {}

class ErrorInternet extends ConnectivityState {
  final String error;

  ErrorInternet(this.error);
}
