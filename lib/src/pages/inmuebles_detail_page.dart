import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ulp_inmo/src/models/inmueble_model.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';

class InmueblesDetailPage extends StatelessWidget {
  const InmueblesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inmueble = ModalRoute.of(context)!.settings.arguments as InmuebleModel;
    return MainScaffold(
      title: const Text(
        "Mi Propiedad",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardImage(inmueble.imageUrl),
              const SizedBox(height: 20),
              ..._buildDescription(context, inmueble),
              const SizedBox(height: 20),
              _CardMap(inmueble.latitud, inmueble.longitud),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDescription(BuildContext context, InmuebleModel inmueble) => [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.home_rounded, color: Theme.of(context).colorScheme.secondary, size: 22),
            const Text('Dirección', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          ],
        ),
        Text(inmueble.direccion, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.architecture_outlined, color: Theme.of(context).colorScheme.secondary, size: 22),
            const Text('Superficie', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          ],
        ),
        Text('${inmueble.superficie} m2', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Theme.of(context).colorScheme.secondary, size: 22),
            const Text('Latitud', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          ],
        ),
        Text(inmueble.latitud.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Theme.of(context).colorScheme.secondary, size: 22),
            const Text('Longitud', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          ],
        ),
        Text(inmueble.longitud.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey)),
      ];
}

class _CardImage extends StatelessWidget {
  final String imageUrl;
  const _CardImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _CardMap extends StatefulWidget {
  final double lat;
  final double lng;
  late LatLng location;

  _CardMap(this.lat, this.lng) {
    location = LatLng(lat, lng);
  }

  @override
  State<_CardMap> createState() => _CardMapState();
}

class _CardMapState extends State<_CardMap> {
  late final MapController mapController;

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
    return Container(
      height: 600,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: widget.location,
              zoom: widget.lat == 0 && widget.lng == 0 ? 2 : 15,
              maxZoom: 15,
              minZoom: 2,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    rotate: true,
                    width: 80.0,
                    height: 80.0,
                    point: widget.location,
                    builder: (ctx) => Icon(Icons.location_on, color: Colors.red, size: 40),
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
                    onPressed: () => mapController.move(widget.location, 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
