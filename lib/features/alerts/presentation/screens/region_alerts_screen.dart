import 'package:flutter/material.dart';
import '../../data/location_items.dart';
import 'package:go_router/go_router.dart';
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
            elevation: 2,
            shadowColor: const Color(0x22000000),
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 2,

            centerTitle: true,

            backgroundColor: const Color(0xFFF2FAF0),

            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black87,
                size: 22,
              ),
              onPressed: () => context.pop(),
            ),

            title: const Text(
              "Region Alerts",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  tooltip: "Оновити",
                  onPressed: () => _controller.loadAlert(),
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.black87,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),

          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),

              child: Column(
                children: [
                  Container(
                    height: 58,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(20),

                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          offset: Offset(0, 3),
                          color: Color(0x15000000),
                        ),
                      ],
                    ),
                    child: DropdownMenu(
                      expandedInsets: EdgeInsets.zero,
                      width: 361,

                      hintText: "Оберіть область",

                      initialSelection: _controller.selectedLocation,

                      leadingIcon: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.black54,
                      ),

                      trailingIcon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.black54,
                      ),

                      textStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                      ),

                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 15,
                        ),
                      ),

                      dropdownMenuEntries: locationItems
                          .map(
                            (item) => DropdownMenuEntry(
                              value: item,
                              label: item.title,
                            ),
                          )
                          .toList(),

                      onSelected: (value) {
                        if (value == null) return;

                        _controller.selectLocation(value);
                        _controller.loadAlert();
                      },
                    ),
                  ),

                  const SizedBox(height: 195),

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

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 350),

                            width: 361,

                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 22,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.92),

                              borderRadius: BorderRadius.circular(22),

                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x14000000),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: _controller.isAlertActive!
                                      ? Colors.red
                                      : const Color(0xFF22B14C),

                                  child: Icon(
                                    _controller.isAlertActive!
                                        ? Icons.warning_rounded
                                        : Icons.check_rounded,

                                    color: Colors.white,
                                    size: 44,
                                  ),
                                ),

                                const SizedBox(height: 26),

                                Text(
                                  _controller.isAlertActive!
                                      ? "Активна\nповітряна тривога"
                                      : "Немає тривоги",

                                  textAlign: TextAlign.center,

                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                    height: 1.15,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                if (_controller.selectedLocation != null)
                                  Text(
                                    _controller.selectedLocation!.title,

                                    textAlign: TextAlign.center,

                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            ),
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
