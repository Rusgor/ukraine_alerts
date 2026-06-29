import 'package:flutter/material.dart';
import '../../domain/models/ukraine_region.dart';
import '../controllers/alerts_map_controller.dart';

class AlertsMapScreen extends StatefulWidget {
  const AlertsMapScreen({super.key});

  @override
  State<AlertsMapScreen> createState() => _AlertsMapScreenState();
}

class _AlertsMapScreenState extends State<AlertsMapScreen> {
  final AlertsMapController _controller = AlertsMapController();

  @override
  void initState() {
    super.initState();

    _controller.loadAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFACDCF7),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF7EC8F2), Color(0xFFACDCF7)],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  //-----------------------------------
                  // AppBar
                  //-----------------------------------
                  Container(
                    color: const Color(0xFFBFDDF3),
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black87,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Alerts Map',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.refresh_outlined,
                            size: 28,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  //-----------------------------------
                  // Ukraine Map
                  //-----------------------------------
                  SizedBox(
                    height: 261,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Image.asset(
                            'assets/images/ukraine_map.png',
                            fit: BoxFit.contain,
                          ),
                        ),

                        if (_controller.isRegionActive(UkraineRegion.luhansk))
                          const Positioned(
                            top: 40,
                            right: 70,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  //-----------------------------------
                  // Cards
                  //-----------------------------------
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (_controller.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (_controller.error != null) {
                          return Center(
                            child: Text(
                              _controller.error!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _controller.alerts.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),

                          itemBuilder: (context, index) {
                            final alert = _controller.alerts[index];

                            final region = alert.region;

                            return _AlertCard(
                              region: region?.title ?? alert.locationTitle,
                              date: alert.startedAt.toString(),
                            );
                          },
                        );
                      },
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

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.region, required this.date});

  final String region;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFC4E6F9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_rounded, color: Colors.redAccent, size: 32),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  region,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
