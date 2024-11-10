import 'package:flutter/material.dart';
import 'package:flutter_test_tots/app/core/models/client_model.dart';
import 'package:flutter_test_tots/ui/viewmodels/clients_viewmodel.dart';

import 'package:google_fonts/google_fonts.dart';

class CardClient extends StatelessWidget {
  const CardClient({
    super.key,
    required this.width,
    required this.height,
    required this.viewModel,
    required this.index,
    required this.client,
    this.onPressed,
  });

  final double width;
  final double height;
  final ClientsViewModel viewModel;
  final int index;
  final Client client;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = viewModel.selectedCardIndex == index;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
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
                backgroundImage: NetworkImage(client.photo == null
                    ? "https://img.freepik.com/vector-premium/icono-usuario-avatar-perfil-usuario-icono-persona-imagen-perfil-silueta-neutral-genero-adecuado_697711-1132.jpg?w=900"
                    : client.photo!),
                radius: width * 0.0641025641,
              ),
              SizedBox(width: width * 0.03076923077),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${client.firstname ?? ''} ${client.lastname ?? ''}',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: width * 0.000641025641,
                        color: const Color(0xFF0D0D0D),
                      ),
                    ),
                    Text(
                      client.email ?? "",
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
              IconButton(
                onPressed: () {
                  viewModel.toggleSelectedCardIndex(index);
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.more_vert,
                  size: width * 0.04102564103,
                  color: const Color(0xFF000000),
                ),
              ),
            ],
          ),
        ),
        if (isSelected)
          Positioned(
            top: height * 0.0177725118,
            right: width * 0.1220512821,
            child: SizedBox(
              height: height * 0.0710900474,
              child: FloatingActionButton.extended(
                onPressed: () {
                  onPressed?.call();
                  viewModel
                      .toggleSelectedCardIndex(viewModel.selectedCardIndex!);
                },
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: width * 0.0615384615,
                ),
                label: Container(
                  padding: EdgeInsets.only(right: width * 0.070256410),
                  child: Center(
                    child: Text(
                      "Edit",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 0.5, // Ajusta según tu necesidad
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Borde con radio de 10
                ),
              ),
            ),
          ),
      ],
    );
  }
}
