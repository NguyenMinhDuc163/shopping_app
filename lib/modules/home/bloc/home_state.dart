sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeInProgress extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure({this.message = 'Lấy dữ liệu thất bại'});
}

class HomeError extends HomeState {
  final String message;

  HomeError({this.message = 'Đã xảy ra lỗi'});
}

class ProductInitial extends HomeState {}

class ProductInProgress extends HomeState {}

class ProductSuccess extends HomeState {}

class ProductFailure extends HomeState {
  final String message;

  ProductFailure({this.message = 'Lấy dữ liệu thất bại'});
}

class ProductError extends HomeState {
  final String message;

  ProductError({this.message = 'Đã xảy ra lỗi'});
}
