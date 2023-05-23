import 'package:flutter/cupertino.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class PartidoProfilePage extends StatefulWidget {
  const PartidoProfilePage({Key? key, required this.partidoID})
      : super(key: key);
  final int partidoID;
  @override
  State<PartidoProfilePage> createState() => _PartidoProfilePageState();
}

class _PartidoProfilePageState extends State<PartidoProfilePage> {
  final CamaraApi _api = CamaraApi();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: FutureBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return Container();
      },
    ));
  }
}
