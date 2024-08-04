import 'package:flutter/material.dart';

// class BackgroudContainer extends StatelessWidget {
//   BackgroudContainer({super.key,
//     required this.image
//   });
//
//   String image;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration:  BoxDecoration(
//         image: DecorationImage(
//           opacity: 0.8,
//             image: AssetImage(image), fit: BoxFit.cover),
//       ),
//     );
//   }
// }

class BackgroudContainer extends StatelessWidget {
   BackgroudContainer({
    super.key,
  });
  Color backgroundColor =const  Color(0x803a3b45);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(colors: [
         backgroundColor,
         const  Color.fromARGB(92, 95, 167, 231),
        ]),
      ),
    );
  }
}