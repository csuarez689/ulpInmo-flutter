import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:ulp_inmo/src/helpers/notifications.dart';
import 'package:ulp_inmo/src/services/inmueble_services.dart';
import 'package:ulp_inmo/src/models/inmueble_model.dart';

import 'package:ulp_inmo/src/widgets/custom_error_widget.dart';
import 'package:ulp_inmo/src/pages/main_scaffold.dart';

class InmueblesListPage extends StatefulWidget {
  const InmueblesListPage({Key? key}) : super(key: key);

  @override
  State<InmueblesListPage> createState() => _InmueblesListPageState();
}

class _InmueblesListPageState extends State<InmueblesListPage> {
  late Future<List<InmuebleModel>?> getAll;
  late InmuebleService provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<InmuebleService>(context, listen: false);
    getAll = provider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      navIndex: 2,
      title: const Text(
        "Mis Propiedades",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: FutureBuilder<List<InmuebleModel>?>(
        future: getAll,
        builder: (context, AsyncSnapshot<List<InmuebleModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            return snapshot.data!.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(
                        "Aun no tienes propiedades agregadas!",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey[500], fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => _ListItem(
                      item: snapshot.data![index],
                      onTap: () => Navigator.pushNamed(context, '/inmuebles/detail', arguments: snapshot.data![index]),
                      onTapEdit: () => Navigator.pushNamed(context, '/inmuebles/form', arguments: snapshot.data![index]).then(_refreshData),
                      onTapDelete: () => deleteAlert(
                        context,
                        message: '¿Esta seguro que desea realizar esta acción? Los cambios son permanentes.',
                        onOk: () => deleteInmueble(snapshot.data![index]),
                      ),
                    ),
                    itemExtent: 150,
                  );
          }
          return const CustomErrorWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/inmuebles/form').then(_refreshData),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  FutureOr _refreshData(value) {
    if (value == true) {
      setState(() => {getAll = provider.getAll()});
    }
  }

  Future<void> deleteInmueble(InmuebleModel inmueble) async {
    Navigator.pop(context);
    final res = await provider.delete(inmueble.id);
    if (res != null) {
      showSnackbar(context, res);
      _refreshData(true);
    } else {
      showSnackbar(context, 'No se pudo eliminar el inmueble');
    }
  }
}

class _ListItem extends StatelessWidget {
  final InmuebleModel item;
  final VoidCallback onTap;
  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;

  const _ListItem({Key? key, required this.item, required this.onTap, required this.onTapEdit, required this.onTapDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor,
            border: Border.all(color: Theme.of(context).primaryColor, width: .5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Slidable(
              key: ValueKey(item.id),
              endActionPane: ActionPane(
                extentRatio: .5,
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                      onPressed: (_) => onTapEdit(), backgroundColor: Colors.yellow[800]!, foregroundColor: Colors.white, icon: Icons.archive, label: 'Editar'),
                  SlidableAction(
                    onPressed: (_) => onTapDelete(),
                    backgroundColor: Colors.red[600]!,
                    foregroundColor: Colors.white,
                    icon: Icons.delete_forever,
                    label: 'Eliminar',
                  ),
                ],
              ),
              child: InkWell(
                onTap: onTap,
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
                      child: Container(
                        color: Colors.white,
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
          ),
        ),
      ),
    );
  }
}
