part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    this.loader = false,
    this.nameError = '',
    this.phoneNumberError = '',
    this.occupationError = '',
    this.wingError = '',
    this.flatError = '',
    this.moveInDateError = '',
    this.residentTypeError = '',
    this.wing,
    this.flat,
    this.moveInDate = '',
    this.residentType,
    this.vehicleFieldCount = 1,
    this.profileImage,
    this.profileImageUrl,
  });

  final bool loader;
  final String nameError;
  final String phoneNumberError;
  final String occupationError;
  final String wingError;
  final String flatError;
  final String moveInDateError;
  final String residentTypeError;
  final String? wing;
  final String? flat;
  final String moveInDate;
  final String? residentType;
  final int vehicleFieldCount;
  final File? profileImage;
  final String? profileImageUrl;

  EditProfileState copyWith({
    bool? loader,
    String? nameError,
    String? phoneNumberError,
    String? occupationError,
    String? wingError,
    String? flatError,
    String? moveInDateError,
    String? residentTypeError,
    String? wing,
    String? flat,
    String? moveInDate,
    String? residentType,
    int? vehicleFieldCount,
    File? profileImage,
    String? profileImageUrl,
    bool clearProfileImage = false,
  }) {
    return EditProfileState(
      loader: loader ?? this.loader,
      nameError: nameError ?? this.nameError,
      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
      occupationError: occupationError ?? this.occupationError,
      wingError: wingError ?? this.wingError,
      flatError: flatError ?? this.flatError,
      moveInDateError: moveInDateError ?? this.moveInDateError,
      residentTypeError: residentTypeError ?? this.residentTypeError,
      wing: wing ?? this.wing,
      flat: flat ?? this.flat,
      moveInDate: moveInDate ?? this.moveInDate,
      residentType: residentType ?? this.residentType,
      vehicleFieldCount: vehicleFieldCount ?? this.vehicleFieldCount,
      profileImage: clearProfileImage
          ? null
          : (profileImage ?? this.profileImage),
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  List<Object?> get props => [
    loader,
    nameError,
    phoneNumberError,
    occupationError,
    wingError,
    flatError,
    moveInDateError,
    residentTypeError,
    wing,
    flat,
    moveInDate,
    residentType,
    vehicleFieldCount,
    profileImage,
    profileImageUrl,
  ];
}
