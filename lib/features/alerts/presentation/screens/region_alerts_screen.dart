import 'package:flutter/material.dart';
import '../../data/location_items.dart';
import '../controllers/region_alerts_controller.dart';


class RegionAlertsScreen extends StatefulWidget {
  const RegionAlertsScreen({super.key});

  @override
  State<RegionAlertsScreen> createState() => _RegionAlertsScreenState();
}

class _RegionAlertsScreenState extends State<RegionAlertsScreen> {
  final RegionAlertsController _controller = RegionAlertsController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Color backgroundColor;

        if (_controller.isAlertActive == true) {
          backgroundColor = const Color(0xFFFFD7D7);
        } else if (_controller.isAlertActive == false) {
          backgroundColor = const Color(0xFFD9FFD9);
        } else {
          backgroundColor = Colors.white;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Region Alerts"),
            centerTitle: true,
          ),
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  DropdownMenu(
                    width: 350,
                    initialSelection: _controller.selectedLocation,
                    label: const Text("Оберіть регіон"),
                    dropdownMenuEntries: locationItems
                        .map(
                          (item) => DropdownMenuEntry(
                            value: item,
                            label: item.title,
                          ),
                        )
                        .toList(),
                    onSelected: (value) {
                      if (value != null) {
                        _controller.selectLocation(value);
                        _controller.loadAlert();
                      }
                    },
                  ),

                  const SizedBox(height: 40),

                  Expanded(
                    child: Center(
                      child: Builder(
                        builder: (context) {
                          if (_controller.isLoading) {
                            return const CircularProgressIndicator();
                          }

                          if (_controller.error != null) {
                            return Text(
                              _controller.error!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            );
                          }

                          if (_controller.isAlertActive == null) {
                            return const Text(
                              "Оберіть область зі списку",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _controller.isAlertActive!
                                    ? Icons.warning_rounded
                                    : Icons.check_circle,
                                color: _controller.isAlertActive!
                                    ? Colors.red
                                    : Colors.green,
                                size: 90,
                              ),

                              const SizedBox(height: 24),

                              Text(
                                _controller.isAlertActive!
                                    ? "Увага!\nАктивна повітряна тривога"
                                    : "Повітряна тривога\nвідсутня",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),

                              if (_controller.selectedLocation != null)
                                Text(
                                  _controller.selectedLocation!.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}