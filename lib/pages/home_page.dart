import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/background.jpg'))),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.2),
            width: size.width,
            height: size.height,
            child: const Column(children: [
              Spacer(),
              Expanded(
                  child: Row(
                children: [PartidosWidget()],
              )),
              Spacer(
                flex: 2,
              )
            ]),
          ),
        ),
      ],
    ));
  }
}

class PartidosWidget extends StatefulWidget {
  const PartidosWidget({Key? key}) : super(key: key);

  @override
  State<PartidosWidget> createState() => _PartidosWidgetState();
}

class _PartidosWidgetState extends State<PartidosWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 90,
            width: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  'images/flag_partido.png',
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith(
                    (states) => ColorLib.pinkBrown.color,
                  ),
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => ColorLib.greyPink.color,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Visualizar Partidos',
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}

// class MainMenuOption extends StatefulWidget {
//   const MainMenuOption({
//     Key? key,
//     required this.title,
//     required this.imageAsset,
//     required this.animationMillisecondsDuration,
//     required this.callback,
//   }) : super(key: key);

//   final String title;
//   final String imageAsset;
//   final VoidCallback callback;
//   final int animationMillisecondsDuration;

//   @override
//   State<MainMenuOption> createState() => _MainMenuOptionState();
// }

// class _MainMenuOptionState extends State<MainMenuOption>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _opacityAnimation;
//   late bool _isTapped = false;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(milliseconds: widget.animationMillisecondsDuration),
//       vsync: this,
//     );

//     _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeOut,
//       ),
//     );

//     _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeIn,
//       ),
//     );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onHighlightChanged: (value) {
//           setState(() {
//             _isTapped = value;
//           });
//         },
//         onTap: widget.callback,
//         child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, snapshot) {
//               return Opacity(
//                 opacity: _opacityAnimation.value,
//                 child: Transform.scale(
//                   scale: _scaleAnimation.value,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       height: _isTapped ? 70 : 100,
//                       decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: Colors.white, width: 1.5)),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 15),
//                               padding: const EdgeInsets.all(10.0),
//                               clipBehavior: Clip.hardEdge,
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: Image.asset(
//                                     'images/${widget.imageAsset}',
//                                     height: 100,
//                                     width: 100,
//                                   ).image),
//                                   border: Border.all(
//                                       color: ColorLib.darkBlue.color, width: 3),
//                                   shape: BoxShape.circle),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Text(
//                               widget.title,
//                               style: GoogleFonts.montserrat(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   fontSize: 17),
//                             ),
//                           ),
//                           const Spacer(),
//                           const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Icon(
//                               Icons.arrow_forward_ios,
//                               color: Colors.white,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
