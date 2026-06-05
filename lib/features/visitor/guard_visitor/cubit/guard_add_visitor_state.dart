part of 'guard_add_visitor_cubit.dart';

class GuardAddVisitorState extends Equatable {
  const GuardAddVisitorState({
    this.loader = false,
    this.nameError = '',
    this.phoneError = '',
    this.wingError = '',
    this.flatError = '',
    this.purposeError = '',
    this.wing,
    this.flat,
    this.purpose,
    this.visitorImage,
    this.hasCustomImage = false,
  });

  final bool loader;
  final String nameError;
  final String phoneError;
  final String wingError;
  final String flatError;
  final String purposeError;
  final String? wing;
  final String? flat;
  final String? purpose;
  final File? visitorImage;
  final bool hasCustomImage;

  GuardAddVisitorState copyWith({
    bool? loader,
    String? nameError,
    String? phoneError,
    String? wingError,
    String? flatError,
    String? purposeError,
    String? wing,
    String? flat,
    String? purpose,
    File? visitorImage,
    bool? hasCustomImage,
    bool clearVisitorImage = false,
  }) {
    return GuardAddVisitorState(
      loader: loader ?? this.loader,
      nameError: nameError ?? this.nameError,
      phoneError: phoneError ?? this.phoneError,
      wingError: wingError ?? this.wingError,
      flatError: flatError ?? this.flatError,
      purposeError: purposeError ?? this.purposeError,
      wing: wing ?? this.wing,
      flat: flat ?? this.flat,
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
    wingError,
    flatError,
    purposeError,
    wing,
    flat,
    purpose,
    visitorImage,
    hasCustomImage,
  ];
}
