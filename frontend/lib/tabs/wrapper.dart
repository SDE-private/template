import 'package:flutter/material.dart';
import 'package:frontend/tabs/tab_interface.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_sliders/sliders.dart';


class TabViewWrapper extends StatefulWidget {
  Widget to_show;
  TabViewWrapper({super.key, required this.to_show });

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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Center(
                child: widget.to_show
              ),
            )
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.amber,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Number of requests: ${_currentSliderValue.toInt()}"),
                  SfSlider(
                    min: 1,
                    max: 99,
                    stepSize: 1,
                    value: _currentSliderValue,
                    thumbIcon: Center(
                      child: Text("$_currentSliderValue", style: Theme.of(context).textTheme.labelSmall!.apply(color: Theme.of(context).indicatorColor)),
                    ),
                    onChanged: (dynamic newValue) {
                      setState(() {
                        _currentSliderValue = newValue;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: execute_requests,
                    child: const Text("Execute")
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }

  void execute_requests() {
    TabInterface form = widget.to_show as TabInterface;
    final uri = form.get_uri();
    final query_params = form.get_params();
    final url = Uri.http("localhost:8181", uri, query_params);
    print(url);
    for (var i = 0; i < _currentSliderValue.toInt(); i++) {
      http.get(url);
    }
  }
}
