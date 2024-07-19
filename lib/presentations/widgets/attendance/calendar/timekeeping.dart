import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TimekeepingWidget extends StatefulWidget {
  const TimekeepingWidget({super.key});

  @override
  State<TimekeepingWidget> createState() => _TimekeepingWidgetState();
}

class _TimekeepingWidgetState extends State<TimekeepingWidget> {
  Position? _currentLocation;
  late LocationPermission permission;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');

    }
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = position;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      child: Column(
        children: [
          Row(
            children: [
              const Text('longitude'),
              const SizedBox(
                width: 20,
              ),
              Text('${_currentLocation?.longitude}'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text('latitude'),
              const SizedBox(
                width: 20,
              ),
              Text('${_currentLocation?.latitude}'),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                await _determinePosition();
              },
              child: const Text('Click')),
          ElevatedButton(
              onPressed: () async {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GoogleMapPage()),
                );*/
              },
              child: const Text('gg map')),
        ],
      ),
    );
  }
}
