import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:themes/base_color.dart';

class BasePage extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final String? assetBg;
  final Widget? footer;
  final double distance;
  final PreferredSizeWidget? appbar;

  const BasePage(
      {super.key,
      this.header,
      this.appbar,
      required this.body,
      this.assetBg,
      this.footer,
      this.distance = 16.0});

  @override
  Widget build(BuildContext context) {
    final colors = BaseThemeColor.of(context);
    final bool isVisibleFooter =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Scaffold(
      appBar: appbar,
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
          ),
          child: Column(
            children: [
              header ?? Container(),
              Expanded(
                child: Container(child: body),
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isVisibleFooter ? Container() : footer,
    );
  }
}
