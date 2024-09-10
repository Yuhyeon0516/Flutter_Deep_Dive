import 'package:calendar_schedular/component/custom_text_field.dart';
import 'package:calendar_schedular/const/color.dart';
import 'package:calendar_schedular/model/schedule.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDay;
  const ScheduleBottomSheet({
    super.key,
    required this.selectedDay,
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;
  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            top: 16,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _Time(
                  onStartSaved: onStartTimeSaved,
                  onStartValidate: onStartTimeValidate,
                  onEndSaved: onEndTimeSaved,
                  onEndValidate: onEndTimeValidate,
                ),
                const SizedBox(
                  height: 8,
                ),
                _Content(
                  onSaved: onContentSaved,
                  onValidate: onContentValidate,
                ),
                const SizedBox(
                  height: 8,
                ),
                _Categories(
                  selectedColor: selectedColor,
                  onTap: (String color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                _SaveButton(
                  onPressed: onSavePressed,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onStartTimeSaved(String? value) {
    if (value == null) return;

    startTime = int.parse(value);
  }

  String? onStartTimeValidate(String? value) {
    if (value == null) return "값을 입력해주세요.";

    if (int.tryParse(value) == null) return "숫자를 입력해주세요.";

    final time = int.parse(value);

    if (time > 24 || time < 0) return "0~24 사이의 숫자를 입력해주세요.";

    return null;
  }

  void onEndTimeSaved(String? value) {
    if (value == null) return;

    endTime = int.parse(value);
  }

  String? onEndTimeValidate(String? value) {
    if (value == null) return "값을 입력해주세요.";

    if (int.tryParse(value) == null) return "숫자를 입력해주세요.";

    final time = int.parse(value);

    if (time > 24 || time < 0) return "0~24 숫자로 입력해주세요.";

    return null;
  }

  void onContentSaved(String? value) {
    if (value == null) return;

    content = value;
  }

  String? onContentValidate(String? value) {
    if (value == null) return "내용을 입력해주세요.";

    if (value.length < 5) return "5글자 이상을 입력해주세요.";

    return null;
  }

  void onSavePressed() {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      formKey.currentState!.save();

      // final schedule = ScheduleTable(
      //   id: 999,
      //   startTime: startTime!,
      //   endTime: endTime!,
      //   content: content!,
      //   color: selectedColor,
      //   date: widget.selectedDay,
      //   createdAt: DateTime.now(),
      // );

      // Navigator.of(context).pop(schedule);
    }
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text("저장"),
          ),
        ),
      ],
    );
  }
}

typedef OnColorSelected = void Function(String color);

class _Categories extends StatelessWidget {
  final String selectedColor;
  final OnColorSelected onTap;

  const _Categories({
    super.key,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categoryColors
          .map(
            (e) => GestureDetector(
              onTap: () {
                onTap(e);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(
                    int.parse("FF$e", radix: 16),
                  ),
                  shape: BoxShape.circle,
                  border: selectedColor == e
                      ? Border.all(
                          color: Colors.black,
                          width: 4,
                        )
                      : null,
                ),
                width: 32,
                height: 32,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;
  const _Content({
    super.key,
    required this.onSaved,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: "내용",
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;

  const _Time({
    super.key,
    required this.onStartSaved,
    required this.onEndSaved,
    required this.onStartValidate,
    required this.onEndValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: "시작 시간",
            onSaved: onStartSaved,
            validator: onStartValidate,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: CustomTextField(
            label: "마감 시간",
            onSaved: onEndSaved,
            validator: onEndValidate,
          ),
        ),
      ],
    );
  }
}
