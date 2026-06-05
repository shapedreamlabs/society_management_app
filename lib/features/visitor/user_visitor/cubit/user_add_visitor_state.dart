part of 'user_add_visitor_cubit.dart';

class UserAddVisitorState extends Equatable {
  const UserAddVisitorState({
    this.loader = false,
    this.nameError = '',
    this.phoneError = '',
    this.dateError = '',
    this.timeError = '',
    this.purposeError = '',
    this.visitDate = '',
    this.visitTime = '',
    this.purpose,
    this.visitorImage,
    this.hasCustomImage = false,
  });

  final bool loader;
  final String nameError;
  final String phoneError;
  final String dateError;
  final String timeError;
  final String purposeError;
  final String visitDate;
  final String visitTime;
  final String? purpose;
  final File? visitorImage;
  final bool hasCustomImage;

  UserAddVisitorState copyWith({
    bool? loader,
    String? nameError,
    String? phoneError,
    String? dateError,
    String? timeError,
    String? purposeError,
    String? visitDate,
    String? visitTime,
    String? purpose,
    File? visitorImage,
    bool? hasCustomImage,
    bool clearVisitorImage = false,
  }) {
    return UserAddVisitorState(
      loader: loader ?? this.loader,
      nameError: nameError ?? this.nameError,
      phoneError: phoneError ?? this.phoneError,
      dateError: dateError ?? this.dateError,
      timeError: timeError ?? this.timeError,
      purposeError: purposeError ?? this.purposeError,
      visitDate: visitDate ?? this.visitDate,
      visitTime: visitTime ?? this.visitTime,
      purpose: purpose ?? this.purpose,
      visitorImage: clearVisitorImage
          ? null
          : (visitorImage ?? this.visitorImage),
      hasCustomImage: hasCustomImage ?? this.hasCustomImage,
    );
  }

  @override
  List<Object?> get props => [
    loader,
    nameError,
    phoneError,
    dateError,
    timeError,
    purposeError,
    visitDate,
    visitTime,
    purpose,
    visitorImage,
    hasCustomImage,
  ];
}
