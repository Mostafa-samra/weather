import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather/model/weatherdata.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final formController = TextEditingController(text: 'mansura');
  bool isLoading = false;
  WeatherData? model;
  getData() async {
    isLoading = true;

    setState(() {});

    final response = await Dio().get(
        "https://api.openweathermap.org/data/2.5/weather?q=${formController.text}&appid=509dc5d730ff2dd6003b22f30ae93313");
    print("response.data : ${response.data}");
    try {
      model = WeatherData.fromJson(response.data);

      isLoading = false;

      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(controller: formController),
              sizedBox(),
              ElevatedButton(
                  onPressed: () {
                    getData();
                  },
                  child: const Text("Get")),
              sizedBox(),
              isLoading
                  ? const CircularProgressIndicator()
                  : model != null
                      ? Column(
                          children: [
                            textSizedBox(text: model!.name),
                            textSizedBox(text: model!.main.temp.toString()),
                            //  textSizedBox(text: model.coord.toString()),
                          ],
                        )
                      : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textSizedBox({required String text}) => Column(
        children: [
          Text(text),
          const SizedBox(
            height: 5.0,
          )
        ],
      );

  SizedBox sizedBox() => const SizedBox(
        height: 20.0,
      );
}
