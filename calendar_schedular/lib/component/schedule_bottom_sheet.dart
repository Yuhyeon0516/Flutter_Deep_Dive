import 'package:calendar_schedular/component/custom_text_field.dart';
import 'package:calendar_schedular/const/color.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({
    super.key,
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
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
          child: Column(
            children: [
              const _Time(),
              const SizedBox(
                height: 8,
              ),
              const _Content(),
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
              const _SaveButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
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

  const _Categories(
      {super.key, required this.selectedColor, required this.onTap});

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
  const _Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: CustomTextField(
        label: "내용",
        expand: true,
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: "시작 시간",
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: CustomTextField(
            label: "마감 시간",
          ),
        ),
      ],
    );
  }
}
