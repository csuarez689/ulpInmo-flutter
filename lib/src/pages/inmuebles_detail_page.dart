import 'package:flutter/material.dart';

import 'package:ulp_inmo/src/models/inmueble_model.dart';
import 'package:ulp_inmo/src/pages/main_scaffold.dart';
import 'package:ulp_inmo/src/widgets/single_marker_map.dart';

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
              SizedBox(
                height: 400,
                width: double.infinity,
                child: SingleMarkerMap(
                  lat: inmueble.latitud,
                  lng: inmueble.longitud,
                  onMapTap: (_, __) {},
                ),
              ),
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
