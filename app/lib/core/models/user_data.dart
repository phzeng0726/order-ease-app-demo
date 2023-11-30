import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.languageId,
  });

  final String? id;
  final String email;
  final String firstName;
  final String lastName;
  final int languageId;

  factory UserData.empty() => const UserData(
        email: '',
        firstName: '',
        lastName: '',
        languageId: 1,
      );
  factory UserData.anonymous(String firebaseUid) => UserData(
        id: firebaseUid,
        email: 'anonymous@mail.com',
        firstName: 'anonymous',
        lastName: 'anonymous',
        languageId: 1,
      );

  UserData copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    int? languageId,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      languageId: languageId ?? this.languageId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        languageId,
      ];
}
