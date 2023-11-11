import 'package:flutter/material.dart';

class TabViewWrapper extends StatefulWidget {
  Widget to_show;
  TabViewWrapper({super.key, required Widget this.to_show });

  @override
  State<TabViewWrapper> createState() => _TabViewWrapperState();
}

class _TabViewWrapperState extends State<TabViewWrapper> {
  double _currentSliderValue = 50;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: widget.to_show,
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.amber,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Number of requests"),
                  Slider(
                    value: _currentSliderValue,
                    min: 1,
                    max: 100,
                    divisions: 50,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ],
              ),
            )
          )
        ],
      )
    );
  }
}
