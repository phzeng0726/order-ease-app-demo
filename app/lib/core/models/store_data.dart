import 'package:equatable/equatable.dart';

class StoreData extends Equatable {
  const StoreData({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.phone,
    required this.address,
    required this.timezone,
    required this.isBreak,
  });

  final String id;
  final String userId;
  final String name;
  final String description;
  final String phone;
  final String address;
  final String timezone;
  final bool isBreak;

  factory StoreData.empty() => const StoreData(
        id: '',
        userId: '',
        name: '',
        description: '',
        phone: '',
        address: '',
        timezone: '',
        isBreak: false,
      );

  StoreData copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    String? phone,
    String? address,
    String? timezone,
    bool? isBreak,
  }) {
    return StoreData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      timezone: timezone ?? this.timezone,
      isBreak: isBreak ?? this.isBreak,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        description,
        phone,
        address,
        timezone,
        isBreak,
      ];
}
