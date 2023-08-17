import 'package:defiraiser_mobile/core/global/constants/app_icons.dart';
import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/appbar/appbar.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/textfield/textfield.dart';
import 'package:defiraiser_mobile/core/utils/input_validation.dart';
import 'package:defiraiser_mobile/core/utils/loading_overlay.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/signup/states/create_password_bloc/bloc/create_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen>
    with
        InputValidationMixin,
        SingleTickerProviderStateMixin,
        LoadingOverlayMixin {
  late AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  // Bouncing Animation
  late Animation<double> animation =
      Tween<double>(begin: 0, end: 1).animate(controller);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final isHide = ValueNotifier<bool>(true);
  final capital = ValueNotifier<bool>(false);
  final number = ValueNotifier<bool>(false);
  final isNotEmpty = ValueNotifier<bool>(false);
  final special = ValueNotifier<bool>(false);
  final chacterLength = ValueNotifier<bool>(false);
  final enabled = ValueNotifier<bool>(false);
  final isConfirmHide = ValueNotifier<bool>(true);
  final isSwitched = ValueNotifier<bool>(false);
  OverlayEntry? _overlayEntry;

  final passwordMatch = ValueNotifier<bool>(false);
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordController.addListener(_checkChanged);
    _confirmPasswordController.addListener(_checkChangedConfrim);

    super.initState();
  }

  _checkChangedConfrim() {
    setState(() {
      passwordMatch.value =
          _passwordController.text == _confirmPasswordController.text;
      enabled.value = capital.value &&
          number.value &&
          special.value &&
          chacterLength.value &&
          passwordMatch.value;
    });
  }

  _checkChanged() {
    setState(() {
      passwordMatch.value =
          _passwordController.text == _confirmPasswordController.text;
      capital.value = _passwordController.text.contains(RegExp(r'[A-Z]'));
      number.value = _passwordController.text.contains(RegExp(r'[0-9]'));

      special.value =
          _passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      chacterLength.value = _passwordController.text.length >= 8;

      enabled.value = capital.value &&
          number.value &&
          special.value &&
          chacterLength.value &&
          passwordMatch.value;

      isNotEmpty.value = _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          isBack: true,
          title: AppTexts.changePassword,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  hintText: AppTexts.password,
                  controller: _passwordController,
                  obscureText: isHide.value,
                  inputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isHide.value = !isHide.value;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SvgPicture.asset(
                          isHide.value ? AppIcons.eye : AppIcons.eyeSplash,
                          color: AppColors.grey100,
                          height: 10,
                          width: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalMargin(10),
                AppTextField(
                  hintText: AppTexts.confirmPassword,
                  controller: _confirmPasswordController,
                  obscureText: isConfirmHide.value,
                  inputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isConfirmHide.value = !isConfirmHide.value;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SvgPicture.asset(
                          isConfirmHide.value
                              ? AppIcons.eye
                              : AppIcons.eyeSplash,
                          color: AppColors.grey100,
                          height: 10,
                          width: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalMargin(20),
                // AnimatedOpacity of the password checker
                AnimatedContainer(
                  height: !enabled.value ? 150 : 0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: AnimatedOpacity(
                    opacity: isNotEmpty.value ? 1 : 0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutBack,
                    child: _passwordChecker(
                      isCapital: capital.value,
                      isNumber: number.value,
                      isSpecial: special.value,
                      isPasswordMatch: passwordMatch.value,
                      isChacterLength: chacterLength.value,
                      enabled: enabled.value,
                    ),
                  ),
                ),
                BlocConsumer<CreatePasswordBloc, CreatePasswordState>(
                  listener: _listener,
                  builder: (context, state) {
                    return AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget? child) {
                          return AnimatedOpacity(
                            opacity: enabled.value ? 1 : 0,
                            duration: const Duration(milliseconds: 500),
                            child: AppButton(
                              text: AppTexts.looksGood,
                              isActive: enabled.value,
                              onTap: () {
                                _passwordNode.unfocus();
                                _confirmPasswordNode.unfocus();
                                //FIXME: Navigate to login screen

                                // context
                                //     .read<CreatePasswordBloc>()
                                //     .add(CreatePasswordEq(
                                //       biometrics: isSwitched.value,
                                //       username: widget.username,
                                //       password: _passwordController.text,
                                //     ));
                              },
                              textColor: AppColors.white100,
                              textSize: 12,
                              color: AppColors.primaryColor,
                            ),
                          );
                        });
                  },
                ),

                // Use Biometrics with switch
                VerticalMargin(10),
              ],
            ),
          )),
        ),
      ),
    );
  }

  void _listener(BuildContext context, CreatePasswordState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, creatingPassword: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, createPasswordError: (message) {
      _overlayEntry?.remove();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }, createPasswordSuccess: (message) {
      _overlayEntry?.remove();
      context.goNamed(RouteConstants.login);
    });
  }

  Container _passwordChecker(
      {required bool isCapital,
      required bool isNumber,
      required bool isSpecial,
      required bool isChacterLength,
      required bool isPasswordMatch,
      required bool enabled}) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.textfieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(children: [
        _passwordCheckerItem(
          enabled: isCapital,
          text: AppTexts.capitalLetter,
        ),
        _passwordCheckerItem(
          enabled: isNumber,
          text: AppTexts.number,
        ),
        _passwordCheckerItem(
          enabled: isSpecial,
          text: AppTexts.specialCharacter,
        ),
        _passwordCheckerItem(
          enabled: isChacterLength,
          text: AppTexts.chacterLength,
        ),
        _passwordCheckerItem(
          enabled: isPasswordMatch,
          text: AppTexts.passwordNotMatch,
        ),
      ]),
    );
  }

  _passwordCheckerItem({required bool enabled, required String text}) {
    return AnimatedContainer(
      curve: Curves.easeInOutBack,
      duration: const Duration(milliseconds: 500),
      child: Row(
        children: [
          Center(
            child: SvgPicture.asset(
              enabled ? AppIcons.success : AppIcons.error,
              color: enabled ? AppColors.successColor : AppColors.errorColor,
              height: 12,
              width: 12,
            ),
          ),
          HorizontalMargin(5),
          Text(text,
              style: Config.b3(context).copyWith(
                color: enabled ? AppColors.grey100 : AppColors.errorColor,
              )),
        ],
      ),
    );
  }
}