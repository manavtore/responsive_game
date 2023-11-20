import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'components/slider_widget.dart';
import 'components/slider_widget_2.dart';

class Croci extends StatelessWidget {
  const Croci({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  bool isError = false;
  late Map<String, dynamic> jsonData;
  late String backgroundUrl;
  late String shapeUrl;
  late String overlayUrl;

  double horizontalValue = 0;
  double verticalValue = 0;
  double resizeShapeValue = 1;
  double resizeOverlayValue = 1;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http
          .get(Uri.parse('https://ajanitech.com/temp/flutter-test/app.json'));
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        backgroundUrl = jsonData['background']['url'];
        shapeUrl = jsonData['shape']['url'];
        overlayUrl = jsonData['overlay']['url'];
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Internship Assignment'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
              ? Center(
                  child: ElevatedButton(
                    onPressed: fetchData,
                    child: const Text('Retry'),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        height: 400,
                        child: Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: backgroundUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: 200 -
                                        (312 * resizeShapeValue) / 2 -
                                        35 * verticalValue,
                                    right: 200 -
                                        (104 * resizeShapeValue) / 2 -
                                        140 * horizontalValue,
                                    child: CachedNetworkImage(
                                      imageUrl: shapeUrl,
                                      width: 104 * resizeShapeValue,
                                      height: 312 * resizeShapeValue,
                                    ),
                                  ),
                                  Positioned(
                                    top: 210 -
                                        (312 * resizeShapeValue) / 2 -
                                        35 * verticalValue,
                                    right: 200 -
                                        (182 * resizeOverlayValue) / 2 -
                                        140 * horizontalValue,
                                    child: CachedNetworkImage(
                                      imageUrl: overlayUrl,
                                      width: 182 * resizeOverlayValue,
                                      height: 182 * resizeOverlayValue,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SliderWidget(
                        label: "Move Horizontally",
                        value: horizontalValue,
                        onChanged: (newValue) {
                          setState(() {
                            horizontalValue = newValue.clamp(-1, 1);
                          });
                        },
                      ),
                      SliderWidget(
                        label: "Move Vertically",
                        value: verticalValue,
                        onChanged: (newValue) {
                          setState(() {
                            verticalValue = newValue.clamp(-1, 1);
                          });
                        },
                      ),
                      SliderWidget2(
                        label: "Resize Shape",
                        value: resizeShapeValue,
                        onChanged: (newValue) {
                          setState(() {
                            resizeShapeValue = newValue.clamp(0, 2);
                          });
                        },
                      ),
                      SliderWidget2(
                        label: "Resize Overlay",
                        value: resizeOverlayValue,
                        onChanged: (newValue) {
                          setState(() {
                            resizeOverlayValue = newValue.clamp(0, 2);
                          });
                        },
                      ),
                    ],
                  ),
                ),
    );
  }
}
