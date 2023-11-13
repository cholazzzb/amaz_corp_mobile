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
                DateSelectListTile(
                  label: _label,
                  dayOf100Years: _dayOf100Years,
                  onChanged: onChanged,
                  shape: shape,
                  context: context,
                  formState: formState,
                ),
                if (currentValue != null)
                  FloatingLabel(label: label, context: context),
              ],
            ),
            if (formState.hasError)
              ErrorText(formState: formState, context: context),
          ],
        );
      },
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.formState,
    required this.context,
  });

  final FormFieldState<DateTime> formState;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
}

class DateSelectListTile extends StatelessWidget {
  const DateSelectListTile({
    super.key,
    required String label,
    required Duration dayOf100Years,
    required this.onChanged,
    required this.shape,
    required this.context,
    required this.formState,
  })  : _label = label,
        _dayOf100Years = dayOf100Years;

  final String _label;
  final Duration _dayOf100Years;
  final ValueChanged<DateTime> onChanged;
  final InputBorder shape;
  final BuildContext context;
  final FormFieldState<DateTime> formState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
      child: ListTile(
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
}

class FloatingLabel extends StatelessWidget {
  const FloatingLabel({
    super.key,
    required this.label,
    required this.context,
  });

  final String label;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
        child: Text(
          label,
          style: Theme.of(context).inputDecorationTheme.helperStyle,
        ),
      ),
    );
  }
}
