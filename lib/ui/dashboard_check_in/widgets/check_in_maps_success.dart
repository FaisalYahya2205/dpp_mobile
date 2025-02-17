import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CheckInMapsSuccess extends StatelessWidget {
  const CheckInMapsSuccess({
    super.key,
    required this.currentPositionLatitude,
    required this.currentPositionLongitude,
  });

  final double currentPositionLatitude;
  final double currentPositionLongitude;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                currentPositionLatitude,
                currentPositionLongitude,
              ),
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.dpp_mobile',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      currentPositionLatitude,
                      currentPositionLongitude,
                    ),
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors().primaryColor.withAlpha(50),
                    ),
                    child: Icon(
                      Icons.location_pin,
                      color: AppColors().primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lokasi saat ini",
                        style: createBlackThinTextStyle(12),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "$currentPositionLatitude, $currentPositionLongitude",
                        style: createBlackTextStyle(14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
