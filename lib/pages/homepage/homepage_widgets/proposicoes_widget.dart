import 'package:flutter/material.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';

class ProposicoesWidget extends StatelessWidget {
  const ProposicoesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: size.width * 0.45,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 3, color: ColorLib.greyPink.color),
      ),
      child: const Row(
        children: [],
      ),
    );
  }
}
