import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object?> get props => [];
}


// TODO BlocBuilder, BlocProvider
