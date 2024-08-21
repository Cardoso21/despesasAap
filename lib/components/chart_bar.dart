import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraintis) {
      return Column(
        children: [
          Container(
            height: constraintis.maxHeight * 0.10,
            child: FittedBox(
              child: Text(
                '${value.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: constraintis.maxHeight * 0.05),
          Container(
            height: constraintis.maxHeight * 0.7,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    color: Color.fromRGBO(25, 162, 238, 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor:
                      percentage.isNaN || percentage < 0 ? 0 : percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraintis.maxHeight * 0.05),
          Container(
            height: constraintis.maxHeight * 0.10,
            child: FittedBox(
              child: Text(label,style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
        ],
      );
    });
  }
}
