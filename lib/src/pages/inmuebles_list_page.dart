import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ulp_inmo/src/services/inmueble_services.dart';
import 'package:ulp_inmo/src/models/inmueble_model.dart';

import 'package:ulp_inmo/src/widgets/custom_error_widget.dart';
import 'package:ulp_inmo/src/widgets/main_scaffold.dart';

class InmueblesListPage extends StatefulWidget {
  const InmueblesListPage({Key? key}) : super(key: key);

  @override
  State<InmueblesListPage> createState() => _InmueblesListPageState();
}

class _InmueblesListPageState extends State<InmueblesListPage> {
  @override
  Widget build(BuildContext context) {
    final inmuebleService = Provider.of<InmuebleService>(context);
    setState(() {});
    return MainScaffold(
      navIndex: 2,
      title: const Text(
        "Mis Propiedades",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: FutureBuilder<List<InmuebleModel>?>(
        future: inmuebleService.getAll(),
        builder: (context, AsyncSnapshot<List<InmuebleModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            //TODO:NO HAY INMUEBLES

            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text(
                      "No tienes propiedades",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => _ListItem(item: snapshot.data![index]),
                    itemExtent: 150,
                  );
            //TODO: Mostrar lista de inmuebles
          }
          return const CustomErrorWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/inmuebles/add').then((value) => value != null ? setState(() => {}) : null);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final InmuebleModel item;

  const _ListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/inmuebles/detail', arguments: item);
          },
          child: Row(
            children: [
              SizedBox(
                height: double.infinity,
                width: 150,
                child: ClipRRect(
                  child: Image.asset(item.imageUrl, fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_rounded, color: Theme.of(context).colorScheme.secondary, size: 20),
                          const Text('Dirección', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Flexible(child: Text(item.direccion, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey))),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.architecture_outlined, color: Theme.of(context).colorScheme.secondary, size: 20),
                          const Text('Superficie', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Text('${item.superficie} m2', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
