import 'package:flutter/material.dart';

class NumberToImage extends StatelessWidget {
  final int number;
  const NumberToImage({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: number
            .toString()
            .split("")
            .map(
              (number) => Image.asset(
                'asset/img/$number.png',
                width: 50,
                height: 70,
              ),
            )
            .toList(),
      ),
    );
  }
}
