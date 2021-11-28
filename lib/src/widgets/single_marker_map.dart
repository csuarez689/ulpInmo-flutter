import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SingleMarkerMap extends StatefulWidget {
  const SingleMarkerMap({Key? key, this.lat, this.lng, required this.onMapTap}) : super(key: key);
  final double? lat;
  final double? lng;
  final Function(double, double) onMapTap;

  @override
  State<SingleMarkerMap> createState() => _SingleMarkerMapState();
}

class _SingleMarkerMapState extends State<SingleMarkerMap> {
  late final MapController mapController;
  final defaultCenter = LatLng(-33.2976373, -66.3797058);

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LatLng? location;
    if (widget.lat != null && widget.lng != null) {
      location = LatLng(widget.lat!, widget.lng!);
    }

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onTap: (_, latLng) => widget.onMapTap(latLng.latitude, latLng.longitude),
        center: location ?? defaultCenter,
        zoom: location == null ? 10 : 15,
        maxZoom: 18,
        minZoom: 3,
      ),
      layers: [
        TileLayerOptions(
          additionalOptions: {
            'accessToken': 'pk.eyJ1IjoiY3N1YXJlejY4OSIsImEiOiJja3dpNGNxbWExNG81MnVubzN6bzJpdGZrIn0.1mS4HMqOLwBuzhPjES3kXQ',
            'id': 'mapbox/streets-v11'
          },
          urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}/?access_token={accessToken}",
        ),
        MarkerLayerOptions(
          markers: [
            if (location != null)
              Marker(
                rotate: true,
                width: 80.0,
                height: 80.0,
                point: location,
                builder: (_) => Icon(Icons.location_on, color: Theme.of(context).colorScheme.secondary, size: 40),
              ),
          ],
        ),
      ],
      nonRotatedChildren: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              mini: true,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.my_location_rounded, size: 24, color: Colors.white),
              onPressed: () => mapController.move(location ?? defaultCenter, location == null ? 10 : 15)),
        ),
      ],
    );
  }
}
