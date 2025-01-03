import 'package:flutter/material.dart';
import 'package:riverpod_study/model/coin.dart';

class CoinItem extends StatelessWidget {
  final Coin coin;

  const CoinItem({
    super.key,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${coin.rank} .${coin.name}  (${coin.symbol})',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              child: coin.isActive == true
                  ? const Text('Active',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ))
                  : const Text(
                      'Not active',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
