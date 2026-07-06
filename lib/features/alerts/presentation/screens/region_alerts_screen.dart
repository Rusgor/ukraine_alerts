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
      builder: (context, _) {
        final bool? alert = _controller.isAlertActive;

        return Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: const Color(0xFFEAF7E8),
            elevation: 2,
            shadowColor: const Color(0x22000000),
            surfaceTintColor: Colors.transparent,
            centerTitle: true,

            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 22,
                color: Colors.black87,
              ),
              onPressed: () => context.pop(),
            ),

            title: const Text(
              'Region Alerts',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),

            actions: [
              IconButton(
                tooltip: 'Оновити',
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

                colors: [
                  alert == true
                      ? const Color(0xFFFFCACA)
                      : const Color(0xFF00B050),

                  alert == true
                      ? const Color(0xFFFFE7E7)
                      : const Color(0xFF69F45B),
                ],
              ),
            ),

            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),

                child: Column(
                  children: [
                    //--------------------------------------------
                    // DROPDOWN
                    //--------------------------------------------
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

                    //--------------------------------------------
                    // STATES
                    //--------------------------------------------
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
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 393,
                              minHeight: 158,
                            ),

                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 22,
                            ),

                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //------------------------------------
                                // Circle
                                //------------------------------------
                                Container(
                                  width: 82,
                                  height: 82,

                                  decoration: BoxDecoration(
                                    color: _controller.isAlertActive!
                                        ? const Color(0xFFFF5B5B)
                                        : const Color(0xFF39FF14),

                                    shape: BoxShape.circle,
                                  ),

                                  child: Icon(
                                    _controller.isAlertActive!
                                        ? Icons.warning_rounded
                                        : Icons.check_rounded,

                                    size: 48,

                                    color: _controller.isAlertActive!
                                        ? Colors.white
                                        : const Color(0xFF00B050),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                //------------------------------------
                                // Text
                                //------------------------------------
                                Text(
                                  _controller.isAlertActive!
                                      ? "Активна тривога"
                                      : "Немає тривоги",

                                  textAlign: TextAlign.center,

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    height: 1.15,
                                  ),
                                ),

                                if (_controller.isAlertActive!) ...[
                                  const SizedBox(height: 14),

                                  const Text(
                                    "Негайно пройдіть\nдо найближчого укриття",

                                    textAlign: TextAlign.center,

                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 1.35,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
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
