import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/register/register_bloc.dart';
import 'package:base_app/presentations/bloc/register/register_event.dart';
import 'package:base_app/presentations/bloc/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class DotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  final double width;
  final double height;

  const DotsIndicator({
    super.key,
    required this.currentIndex,
    required this.pageCount,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return Container(
          width: width,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
          color: index <= currentIndex ? const Color(0xff42558A) : const Color(0xff2d2d31),
        );
      }),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final List<bool> checkInput;
  final List<String> valueInputs;

  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.checkInput,
    required this.valueInputs,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: checkInput[currentPageIndex] ? colors.primary : colors.surface,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.65, 44),
                ),
                onPressed: () {
                  _currentPage(state);
                },
                child: Row(
                  children: [
                    Text(
                      currentPageIndex == 2
                          ? appLocalizations.register
                          : appLocalizations.continues,
                      style: TextStyle(
                          fontSize: 18,
                          color: checkInput[currentPageIndex] ? colors.text : colors.textTertiary),
                    ),
                    if (currentPageIndex != 2)
                      SvgPicture.asset(
                          checkInput[currentPageIndex]
                              ? Assets.images.icon.iconNight
                              : Assets.images.icon.iconDark,
                          height: 24,
                          width: 24)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _currentPage(RegisterState state) {
    if (currentPageIndex == 0) {
      dI<RegisterBloc>().add(RegisterEmailInputEvent(valueInputs[0], state.registerRequest));
    }
    if (currentPageIndex == 1) {
      dI<RegisterBloc>().add(RegisterNameInputEvent(valueInputs[1], valueInputs[2], state.registerRequest,));
    }
    if (currentPageIndex == 2) {
      dI<RegisterBloc>().add(RegisterRequestEvent(valueInputs[3], state.registerRequest));
    }
    onUpdateCurrentPageIndex(currentPageIndex + 1);
  }
}
