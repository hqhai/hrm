import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:common/utils/validate_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themes/themes.dart';

class AppInputArea extends StatefulWidget {
  final VoidCallback? onTap;
  final String placeHolder;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final StringValidator? submitValidator;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? onClickIcon;
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
  final String? label;
  final Color? colorBorder;

  const AppInputArea(
      {super.key,
      this.onTap,
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
      this.onValueSelectChange,
      this.onClickIcon,
      this.label,
      this.colorBorder});

  @override
  State<StatefulWidget> createState() => _AppInputAreaState();
}

class _AppInputAreaState extends State<AppInputArea> {
  FocusNode? _focusNode;

  @override
  void initState() {
    _focusNode = _focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              child: Focus(
            onFocusChange: (focus) {
              if (!focus) {
                setState(() {});
              }
            },
            child: TextField(
              onTap: widget.onTap,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              onChanged: (value) {
                if (widget.onChange != null) {
                  widget.onChange!(value);
                }
              },
              enabled: widget.enabled,
              inputFormatters: widget.inputFormatter,
              controller: widget.controller,
              style: theme.textTheme.bodyLarge,
              decoration: InputDecoration(
                labelText: widget.label,
                // contentPadding: const EdgeInsets.only(
                //     bottom: 0,
                //     left: 16,
                //     top: 10,
                //     right: 16 // HERE THE IMPORTANT PART
                //     ),
                suffixIcon: widget.icon != null
                    ? IconButton(
                        onPressed: () {
                          widget.onClickIcon!();
                        },
                        icon: Icon(
                          widget.icon,
                          color: colors.textTertiary,
                        ),
                      )
                    : const SizedBox(),
                hintText: widget.placeHolder,
                hintStyle: theme.textTheme.bodyLarge
                    ?.copyWith(color: colors.textTertiary),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isEmpty(widget.error)
                        ? colors.outline.withValues(alpha: 0.4)
                        : colors.error,
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
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: colors.outline,
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
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.error, fontSize: SpacingUnit.x3),
                    maxLines: 2,
                  ),
                )
        ]);
  }
}
