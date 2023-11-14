import 'package:flutter/material.dart';
import 'package:frontend/tabs/tab_interface.dart';
import 'package:http/http.dart' as http;


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
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
    for (var i = 0; i < _currentSliderValue.toInt(); i++) {
      http.get(url);
    }
  }
}
