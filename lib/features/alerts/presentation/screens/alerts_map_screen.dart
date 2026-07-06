import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/ukraine_map_widget.dart';
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
    _controller.startAutoRefresh();
  }

  @override
  void dispose() {
    _controller.stopAutoRefresh();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
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
                  //--------------------------------------------------
                  // APP BAR
                  //--------------------------------------------------
                  Container(
                    height: 64,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    color: const Color(0xFFBFDDF3),

                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),

                          onPressed: () => context.pop(),
                        ),

                        const Expanded(
                          child: Text(
                            "Alerts Map",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: _controller.loadAlerts,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  //--------------------------------------------------
                  // MAP
                  //--------------------------------------------------
                  Center(
                    child: SizedBox(
                      width: 393,
                      height: 261,
                      child: UkraineMapWidget(controller: _controller),
                    ),
                  ),

                  const SizedBox(height: 16),

                  //--------------------------------------------------
                  // ALERT LIST
                  //--------------------------------------------------
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

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
                                textAlign: TextAlign.center,
                              ),
                            );
                          }

                          if (_controller.alerts.isEmpty) {
                            return const Center(
                              child: Text(
                                "Активних тривог немає",
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }

                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),

                            itemCount: _controller.alerts.length,

                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),

                            itemBuilder: (context, index) {
                              final alert = _controller.alerts[index];

                              return _AlertCard(
                                region:
                                    alert.region?.title ?? alert.locationTitle,

                                date: alert.startedAt.toLocal(),
                              );
                            },
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

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.region, required this.date});

  final String region;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: const Color(0xFFC7E5F7),

        borderRadius: BorderRadius.circular(14),

        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(2, 4),
            color: Color(0x26000000),
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
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "${date.day.toString().padLeft(2, '0')}."
                  "${date.month.toString().padLeft(2, '0')}."
                  "${date.year}   "
                  "${date.hour.toString().padLeft(2, '0')}:"
                  "${date.minute.toString().padLeft(2, '0')}",

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
