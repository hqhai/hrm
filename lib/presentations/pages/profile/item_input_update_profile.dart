import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemInputUpdateProfile extends StatefulWidget {
  final String? error;
  final ValueChanged<String> onChange;
  final String content;
  final String title;
  final bool requiredValidate;

  const ItemInputUpdateProfile({
    super.key,
    this.title = '',
    this.content = '',
    required this.onChange,
    this.error,
    this.requiredValidate = false,
  });

  @override
  State<ItemInputUpdateProfile> createState() => _ItemInputUpdateProfileState();
}

class _ItemInputUpdateProfileState extends State<ItemInputUpdateProfile> {
  late TextEditingController contentController;

  @override
  void initState() {
    contentController = TextEditingController(text: widget.content);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemInputUpdateProfile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync controller when content changes externally (e.g. loadFromUser).
    if (widget.content != oldWidget.content &&
        widget.content != contentController.text) {
      contentController.text = widget.content;
    }
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final hasError = widget.error != null && widget.error!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Row(
            children: [
              Text(
                widget.title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.text.withValues(alpha: 0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.requiredValidate)
                Text(
                  ' *',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: SpacingUnit.x1_5),
          // Input
          TextField(
            controller: contentController,
            maxLines: 1,
            onChanged: widget.onChange,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.text,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: SpacingUnit.x3,
                vertical: SpacingUnit.x3,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                borderSide: BorderSide(
                  color: hasError
                      ? Colors.red
                      : colors.text.withValues(alpha: 0.12),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                borderSide: BorderSide(
                  color: hasError
                      ? Colors.red
                      : colors.text.withValues(alpha: 0.12),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                borderSide: const BorderSide(
                  color: Color(0xFF014282),
                  width: 1.5,
                ),
              ),
            ),
          ),
          // Error
          if (hasError) ...[
            const SizedBox(height: 4),
            Text(
              widget.error!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.red,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
