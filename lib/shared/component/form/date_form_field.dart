import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatelessWidget {
  final ValueChanged<DateTime> onChanged;
  final DateTime? currentValue;
  final FormFieldValidator<DateTime>? validator;
  final String label;

  const DateFormField({
    super.key,
    required this.onChanged,
    this.currentValue,
    this.validator,
    required this.label,
  });

  static const _dayOf100Years = Duration(days: 365 * 100);

  String get _label {
    if (currentValue == null) return label;

    return DateFormat.yMMMd().format(currentValue!);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: currentValue,
      validator: validator,
      builder: (FormFieldState<DateTime> formState) {
        InputBorder shape = switch (formState.hasError) {
              true => Theme.of(context).inputDecorationTheme.errorBorder,
              false => Theme.of(context).inputDecorationTheme.enabledBorder,
            } ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 5.0),
            );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _buildDateSelectListTile(shape, context, formState),
                if (currentValue != null) _buildFloatingLabel(context),
              ],
            ),
            if (formState.hasError) _buildErrorText(formState, context),
          ],
        );
      },
    );
  }

  Widget _buildErrorText(
      FormFieldState<DateTime> formState, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.p8,
        horizontal: Sizes.p16,
      ),
      child: Text(
        formState.errorText!,
        style: Theme.of(context).inputDecorationTheme.errorStyle,
      ),
    );
  }

  Widget _buildDateSelectListTile(
    InputBorder shape,
    BuildContext context,
    FormFieldState<DateTime> formState,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: shape,
        trailing: const Icon(
          Icons.date_range,
          color: Colors.blue,
        ),
        title: Text(_label),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(_dayOf100Years),
            lastDate: DateTime.now().add(_dayOf100Years),
          );

          if (date != null) {
            onChanged(date);
            formState.didChange(date);
          }
        },
      ),
    );
  }

  Widget _buildFloatingLabel(BuildContext context) {
    return Positioned(
      left: 12.0,
      top: -2.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Text(
          label,
          style: Theme.of(context).inputDecorationTheme.helperStyle,
        ),
      ),
    );
  }
}
