import 'package:flutter/material.dart';

import '../singletons/recurrent_calls.dart';

class ExamplesView extends StatefulWidget {
  const ExamplesView({super.key});

  @override
  State<ExamplesView> createState() => _ExamplesViewState();
}

class _ExamplesViewState extends State<ExamplesView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Examples"),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ENDPOINTS.map(
                (e) => make_row(e)
              ).toList()
            ),
          )
        )
      )
    );
  }

  Row make_row(Endpoint endpoint) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(endpoint.uri),
        Slider(
          value: endpoint.requests_per_second.toDouble(),
          min: 0,
          max: 10,
          divisions: 11,
          label: endpoint.requests_per_second.toString(),
          onChanged: (double value) {
            setState(() {
              endpoint.requests_per_second = value.toInt();
            });
          },
        ),
      ],
    );
  }
}
