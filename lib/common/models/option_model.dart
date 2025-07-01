import 'package:equatable/equatable.dart';

class OptionModel extends Equatable {
  final String name;
  final int id;

  const OptionModel({
    required this.name,
    required this.id,
  });

  bool get isAvailable => id != -1 && name.isNotEmpty;
  bool get isUnavailable => isAvailable == false;

  factory OptionModel.unavailable() => const OptionModel(id: -1, name: '');

  @override
  List<Object?> get props => [id, name];
}
