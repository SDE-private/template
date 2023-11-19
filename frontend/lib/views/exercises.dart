import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../singletons/recurrent_calls.dart';

class ExercisesView extends StatefulWidget {
  const ExercisesView({super.key});

  @override
  State<ExercisesView> createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.from([
                Text("Simple APIs", style: Theme.of(context).textTheme.headlineLarge),
                Text("Specify the number of requests per second to these endpoints.", style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 100)
              ]) + List<Widget>.from(ENDPOINTS.map((e) => make_row(e)).toList())

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
        SfSlider(
          min: 0,
          max: 10,
          stepSize: 1,
          value: endpoint.requests_per_second,
          thumbIcon: Center(
            child: Text("${endpoint.requests_per_second}", style: Theme.of(context).textTheme.labelSmall!.apply(color: Theme.of(context).indicatorColor)),
          ),
          onChanged: (dynamic newValue) {
            setState(() {
              endpoint.requests_per_second = newValue;
            });
          },
        ),
      ],
    );
  }
}
