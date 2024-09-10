import 'package:calendar_schedular/component/custom_text_field.dart';
import 'package:calendar_schedular/const/color.dart';
import 'package:calendar_schedular/database/drift.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final int? id;
  final DateTime selectedDay;

  const ScheduleBottomSheet({
    super.key,
    required this.selectedDay,
    this.id,
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  void initState() {
    super.initState();

    initCategory();
  }

  initCategory() async {
    if (widget.id != null) {
      final res = await GetIt.I<AppDatabase>().getScheduleById(widget.id!);

      setState(() {
        selectedColorId = res.category.id;
      });
    } else {
      final res = await GetIt.I<AppDatabase>().getCategories();

      setState(() {
        selectedColorId = res.first.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedColorId == null) {
      return Container();
    }

    return FutureBuilder(
        future: widget.id == null
            ? null
            : GetIt.I<AppDatabase>().getScheduleById(widget.id!),
        builder: (context, snapshot) {
          if (widget.id != null &&
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final schedule = snapshot.data?.schedule;

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
                        startTimeInitValue: schedule?.startTime.toString(),
                        endTimeInitValue: schedule?.endTime.toString(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _Content(
                        onSaved: onContentSaved,
                        onValidate: onContentValidate,
                        initialValue: schedule?.content,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _Categories(
                        selectedColorId: selectedColorId!,
                        onTap: (int color) {
                          setState(() {
                            selectedColorId = color;
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
        });
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

  void onSavePressed() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      formKey.currentState!.save();

      final database = GetIt.I<AppDatabase>();

      if (widget.id != null) {
        await database.updateScheduleById(
          widget.id!,
          ScheduleTableCompanion(
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
            date: Value(widget.selectedDay),
          ),
        );
      } else {
        await database.createSchedule(
          ScheduleTableCompanion(
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
            date: Value(widget.selectedDay),
          ),
        );
      }

      if (!mounted) return;

      Navigator.of(context).pop();
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

typedef OnColorSelected = void Function(int color);

class _Categories extends StatelessWidget {
  final int selectedColorId;
  final OnColorSelected onTap;

  const _Categories({
    super.key,
    required this.selectedColorId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetIt.I<AppDatabase>().getCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: snapshot.data!
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    onTap(e.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(
                        int.parse("FF${e.color}", radix: 16),
                      ),
                      shape: BoxShape.circle,
                      border: selectedColorId == e.id
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
      },
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;
  final String? initialValue;

  const _Content({
    super.key,
    required this.onSaved,
    required this.onValidate,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: "내용",
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
        initialValue: initialValue,
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;
  final String? startTimeInitValue;
  final String? endTimeInitValue;

  const _Time({
    super.key,
    required this.onStartSaved,
    required this.onEndSaved,
    required this.onStartValidate,
    required this.onEndValidate,
    this.startTimeInitValue,
    this.endTimeInitValue,
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
            initialValue: startTimeInitValue,
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
            initialValue: endTimeInitValue,
          ),
        ),
      ],
    );
  }
}
