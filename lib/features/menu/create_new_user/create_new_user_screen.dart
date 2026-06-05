import 'package:society_managment/society_managment.dart';

class CreateNewUserScreen extends StatelessWidget {
  const CreateNewUserScreen({super.key});

  static const routeName = '/create_new_user';

  static Widget builder(BuildContext context) {
    return BlocProvider<CreateNewUserCubit>(
      create: (_) => CreateNewUserCubit(),
      child: const CreateNewUserScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.createNewUser ?? "",
        centerTitle: true,
        color: AppColors.bgColor,
        titleStyle: styleW500S24,
        backIconColor: AppColors.text,
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(
          AppConstants.horizontalPadding,
          0,
          AppConstants.horizontalPadding,
          12.h,
        ),
        child: CustomButton(title: l10n?.createUser ?? "", onTap: () {}),
      ),
      body: BlocBuilder<CreateNewUserCubit, CreateNewUserState>(
        builder: (context, state) {
          final cubit = context.read<CreateNewUserCubit>();

          return CustomSingleChildScroll(
            padding: EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              12.h,
              AppConstants.horizontalPadding,
              16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  header: l10n?.name ?? "",
                  hintText: l10n?.enterName ?? "",
                ),
                14.h.spaceVertical,
                AppTextField(
                  header: l10n?.phoneNumber ?? "",
                  hintText: l10n?.enterPhoneNumber ?? "",
                  textInputType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.wing ?? "",
                  hintText: l10n?.selectWing ?? "",
                  items: cubit.wings,
                  value: state.wing,
                  itemAsString: (value) => value,
                  onChanged: cubit.onWingChanged,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.flat ?? "",
                  hintText: l10n?.selectFlat ?? "",
                  items: cubit.flats,
                  value: state.flat,
                  itemAsString: (value) => value,
                  onChanged: cubit.onFlatChanged,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.role ?? "",
                  hintText: l10n?.selectRole ?? "",
                  items: cubit.roles,
                  value: state.role,
                  itemAsString: (value) => value,
                  onChanged: cubit.onRoleChanged,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
