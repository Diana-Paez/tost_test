import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardClient extends StatelessWidget {
  const CardClient({
    super.key,
    required this.width,
    required this.height,
    required this.name,
    required this.email,
    this.image,
  });

  final double width;
  final double height;
  final String name;
  final String email;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.01895734597),
      width: width,
      height: height * 0.1066350711,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2BC08A).withOpacity(0.1),
              blurRadius: 24.0,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: const Color(0xFF000000),
            width: 1.0,
          )),
      padding: EdgeInsets.only(
          right: width * 0.04102564103, left: width * 0.03846153846),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(image == null
                ? "https://img.freepik.com/vector-premium/icono-usuario-avatar-perfil-usuario-icono-persona-imagen-perfil-silueta-neutral-genero-adecuado_697711-1132.jpg?w=900"
                : image!),
            radius: width * 0.0641025641,
          ),
          SizedBox(width: width * 0.03076923077),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: width * 0.000641025641,
                    color: const Color(0xFF0D0D0D),
                  ),
                ),
                Text(
                  email,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: width * 0.000641025641,
                    color: const Color(0xFF0D0D0D),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.more_vert,
            size: width * 0.04102564103,
            color: const Color(0xFF000000),
          ),
        ],
      ),
    );
  }
}
