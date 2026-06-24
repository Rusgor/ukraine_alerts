import 'package:flutter/material.dart';

class AlertsMapScreen extends StatelessWidget {
  const AlertsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Image.asset(
                    'assets/images/ukraine_map.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              //-----------------------------------
              // Cards
              //-----------------------------------
              const _AlertCard(
                region: 'Луганська область',
                date: 'Apr 4, 2022 16:45:39',
              ),

              const SizedBox(height: 10),

              const _AlertCard(
                region: 'Автономна Республіка Крим',
                date: 'Dec 10, 2022 22:22:00',
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
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
