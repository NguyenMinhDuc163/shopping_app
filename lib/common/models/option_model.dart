import 'package:equatable/equatable.dart';
import 'package:shopping_app/utils/helpers/json_ext.dart';

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

  factory OptionModel.fromLocalJson(Map<String, dynamic> map) {
    return OptionModel(
      id: map.lookup<int>('id'),
      name: map.lookup<String>('name'),
    );
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
