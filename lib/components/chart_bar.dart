import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    required this.label,
    required this.percentage,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.10,
              child: const FittedBox(
                child: Text(
                  'R\$',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.10,
              child: FittedBox(
                child: Text(
                  value.toStringAsFixed(0),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              width: 10,
              height: constraints.maxHeight * 0.60,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.10,
              child: FittedBox(
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
