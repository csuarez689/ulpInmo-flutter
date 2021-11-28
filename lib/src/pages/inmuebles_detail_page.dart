import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import 'package:ulp_inmo/src/models/inmueble_model.dart';
import 'package:ulp_inmo/src/pages/main_scaffold.dart';

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
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardMap(inmueble.latitud, inmueble.longitud),
              _CardImage(inmueble.id, inmueble.imageUrl),
              _TileTextIcon(icon: Icons.home_rounded, title: 'Dirección', value: inmueble.direccion),
              _TileTextIcon(icon: Icons.architecture_outlined, title: 'Superficie', value: '${inmueble.superficie} m2'),
              _TileTextIcon(icon: Icons.location_on, title: 'Latitud', value: inmueble.latitud.toString()),
              _TileTextIcon(icon: Icons.location_on, title: 'Longitud', value: inmueble.longitud.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final String imageUrl;
  final int id;
  const _CardImage(this.id, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: id,
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}

class _TileTextIcon extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _TileTextIcon({Key? key, required this.title, required this.value, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.secondary, size: 22),
            Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class _CardMap extends StatefulWidget {
  final double lat;
  final double lng;
  late final LatLng location;

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
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: ClipRRect(
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: widget.location,
            zoom: widget.lat == 0 && widget.lng == 0 ? 2 : 13,
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
                  builder: (ctx) => Icon(Icons.location_pin, color: Theme.of(context).colorScheme.secondary, size: 40),
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
    );
  }
}
