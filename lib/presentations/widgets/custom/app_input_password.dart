import 'package:common/utils/validate_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themes/themes.dart';

class AppInputPassword extends StatefulWidget {
  final String placeHolder;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final StringValidator? submitValidator;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onValueSelectChange;
  final TextEditingController? controller;
  final bool required;
  final bool enabled;
  final bool autofocus;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final Widget? suffixWidget;
  final Iterable<String>? autofillHints;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final String? error;
  final bool isSubmit;
  final IconData? icon;
  final Widget? iconLeft;
  final bool? hinText;

  const AppInputPassword({
    super.key,
    this.placeHolder = "",
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    this.submitValidator,
    this.onSubmit,
    this.controller,
    this.required = false,
    this.enabled = true,
    this.autofocus = false,
    this.maxLength,
    this.suffixWidget,
    this.minLines,
    this.maxLines,
    this.autofillHints,
    this.onSubmitted,
    this.onChange,
    this.focusNode,
    this.error,
    this.isSubmit = false,
    this.icon,
    this.iconLeft,
    this.onValueSelectChange,
    this.hinText = true,
  });

  @override
  State<StatefulWidget> createState() => _AppInputPasswordState();
}

class _AppInputPasswordState extends State<AppInputPassword> {
  bool hintText = true;
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 48,
            child: Focus(
              onFocusChange: (focus) {
                if (!focus) {
                  // if (widget.required && isEmpty(widget.controller?.text)) {
                  //   widget.error = AppLocalizations.of(context)?.errorEmpty;
                  // } else {
                  //   widget.error = null;
                  // }
                  setState(() {});
                }
              },
              child: TextField(
                onChanged: (value) {
                  if (widget.onChange != null) {
                    widget.onChange!(value);
                  }
                },
                inputFormatters: const [],
                obscureText: hintText,
                controller: widget.controller,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      bottom: 0, left: 16, top: 0, right: 16 // HERE THE IMPORTANT PART
                      ),
                  prefixIcon: widget.iconLeft ?? const SizedBox(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hintText = !hintText;
                        // widget.hinText = !(widget.hinText ?? true);
                      });
                    },
                    icon: hintText == true
                        ? Icon(
                            Icons.visibility_off,
                            color: colors.outline,
                          )
                        : Icon(
                            Icons.visibility,
                            color: colors.outline,
                          ),
                  ),
                  hintText: widget.placeHolder,
                  hintStyle: theme.textTheme.bodyLarge?.copyWith(color: colors.textTertiary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isEmpty(widget.error) ? colors.outline : colors.error,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: colors.primary,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            )),
        isEmpty(widget.error)
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  widget.error!,
                  style: theme.textTheme.bodyLarge?.copyWith(color: colors.error),
                  maxLines: 2,
                ),
              )
      ],
    );
  }
}
