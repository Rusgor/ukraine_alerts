import 'package:flutter/material.dart';
import '../../data/location_items.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      builder: (context, _) {
        final bool? alert = _controller.isAlertActive;

        return Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            elevation: 2,
            shadowColor: const Color(0x22000000),
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 2,

            centerTitle: true,

            backgroundColor: alert == true
                ? const Color(0xFFD98787)
                : const Color(0xFFDDF0D8),

            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 22,
                color: Colors.black87,
              ),
              onPressed: () => context.pop(),
            ),

            title: const Text(
              "Region Alerts",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),

            actions: [
              IconButton(
                tooltip: "Оновити",
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: Colors.black87,
                  size: 24,
                ),
                onPressed: () => _controller.loadAlert(),
              ),
            ],
          ),
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 350),

            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,

                colors: alert == true
                    ? const [Color(0xFFB10000), Color(0xFFFF1F1F)]
                    : const [Color(0xFF00B050), Color(0xFF69F45B)],
              ),
            ),

            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),

                child: Column(
                  children: [
                    //-------------------------------------------------
                    // Dropdown
                    //-------------------------------------------------
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 393),
                      height: 58,

                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),

                        borderRadius: BorderRadius.circular(18),

                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),

                      child: DropdownMenu(
                        expandedInsets: EdgeInsets.zero,

                        width: 361,

                        initialSelection: _controller.selectedLocation,

                        hintText: "Оберіть область",

                        leadingIcon: const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFF1E3A5F),
                        ),

                        trailingIcon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF1E3A5F),
                        ),

                        textStyle: const TextStyle(
                          fontSize: 17,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),

                        inputDecorationTheme: const InputDecorationTheme(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,

                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 16,
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

                    const SizedBox(height: 165),

                    //-------------------------------------------------
                    // STATES
                    //-------------------------------------------------
                    if (_controller.isLoading)
                      const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      )
                    else if (_controller.error != null)
                      Expanded(
                        child: Center(
                          child: Text(
                            _controller.error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    else if (_controller.isAlertActive == null)
                      const Expanded(
                        child: Center(
                          child: Text(
                            "Оберіть область зі списку",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: _controller.isAlertActive == false
                                //==================================================
                                // GREEN SCREEN (не змінюємо)
                                //==================================================
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 82,
                                        height: 82,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF39FF14),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check_rounded,
                                          size: 50,
                                          color: Color(0xFF00B050),
                                        ),
                                      ),

                                      const SizedBox(height: 22),

                                      const Text(
                                        "Немає тривоги",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                //==================================================
                                // RED SCREEN (Pixel Perfect Figma)
                                //==================================================
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/siren.svg',
                                        width: 120,
                                        height: 120,
                                      ),

                                      const SizedBox(height: 34),

                                      const Text(
                                        "Повітряна тривога!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      const Text(
                                        "Будь ласка, пройдіть до укриття",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          height: 1.35,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
