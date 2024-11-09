import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test_tots/app/core/models/client_model.dart';
import 'package:flutter_test_tots/app/core/utils/responsive_screen.dart';
import 'package:flutter_test_tots/ui/shared/widgets/custom_button.dart';
import 'package:flutter_test_tots/ui/viewmodels/client_detail_viewmodel.dart';
import 'package:flutter_test_tots/ui/views/loading/loading_page_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class ClientDetailView extends StatefulWidget {
  const ClientDetailView({super.key});

  @override
  State<ClientDetailView> createState() => _ClientDetailViewState();
}

class _ClientDetailViewState extends State<ClientDetailView> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = getUsableScreenDimension(context, ScreenDimension.width);
    final height = getUsableScreenDimension(context, ScreenDimension.height);
    final clientData = ModalRoute.of(context)!.settings.arguments as Client?;

    return ViewModelBuilder<ClientDetailViewModel>.reactive(
        onViewModelReady: (viewModel) {
          if (clientData != null) {
            controllerName.text = (clientData.firstname ?? "");
            controllerLastName.text = (clientData.lastname ?? "");
            controllerEmail.text = (clientData.email ?? "");
            viewModel.setFirstName(clientData.firstname ?? "");
            viewModel.setLastName(clientData.lastname ?? "");
            viewModel.setEmail(clientData.email ?? "");
          }
        },
        viewModelBuilder: () => ClientDetailViewModel(),
        builder: (context, viewModel, child) {
          return viewModel.isBusy
              ? const LoadingPage()
              : Scaffold(
                  backgroundColor: const Color(0xFFF5F5F5),
                  body: Center(
                    child: Container(
                      width: width * 0.7717948718,
                      height: height * 0.5924170616,
                      padding: EdgeInsets.only(
                          top: height * 0.0296208531,
                          left: width * 0.0641025641,
                          right: width * 0.0461538462,
                          bottom: height * 0.0177725118),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: width * 0.0230769231),
                            child: Text(
                              clientData != null
                                  ? "Edit client"
                                  : "Add new client",
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: const Color(0xFF222222),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.0568720379),
                          Center(
                            child: SizedBox(
                              width: width * 0.3051282051,
                              height: height * 0.1409952607,
                              child: Stack(
                                children: [
                                  CustomPaint(
                                    painter: RPSCustomPainter(),
                                    size: Size(width * 0.3051282051,
                                        height * 0.1409952607),
                                  ),
                                  clientData != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(clientData
                                                      .photo ==
                                                  null
                                              ? "https://img.freepik.com/vector-premium/icono-usuario-avatar-perfil-usuario-icono-persona-imagen-perfil-silueta-neutral-genero-adecuado_697711-1132.jpg?w=900"
                                              : clientData.photo!),
                                          radius: width * 0.3051282051,
                                        )
                                      : Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/icons/iconavatar.svg",
                                                  width: width * 0.0794615385),
                                              SizedBox(
                                                  height:
                                                      height * 0.0117535545),
                                              Text(
                                                "Upload image",
                                                style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: const Color(0xFF080816)
                                                      .withOpacity(0.38),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.0225118483),
                          SizedBox(
                            width: width * 0.6410256410,
                            height: height * 0.0545023697,
                            child: TextField(
                              onChanged: viewModel.setFirstName,
                              controller: controllerName,
                              decoration: InputDecoration(
                                labelText: 'First name*',
                                labelStyle: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xFF222222)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF222222),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.0154028436),
                          SizedBox(
                            width: width * 0.6410256410,
                            height: height * 0.0545023697,
                            child: TextField(
                              onChanged: viewModel.setLastName,
                              controller: controllerLastName,
                              decoration: InputDecoration(
                                labelText: 'Last name*',
                                labelStyle: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xFF222222)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF222222),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.0154028436),
                          SizedBox(
                            width: width * 0.6410256410,
                            height: height * 0.0545023697,
                            child: TextField(
                              onChanged: viewModel.setEmail,
                              controller: controllerEmail,
                              decoration: InputDecoration(
                                labelText: 'Email address*',
                                labelStyle: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xFF222222)),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF222222),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: const Color(0xFF080816)
                                          .withOpacity(0.38)),
                                ),
                              ),
                              CustomButton(
                                height: height * 0.0473933649,
                                width: width * 0.4076923077,
                                title: 'SAVE',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: width * 0.0012820513,
                                  color: const Color(0xFFFFFFFF),
                                ),
                                onPressed: viewModel.isEnabled()
                                    ? () {
                                        if (clientData != null) {
                                          viewModel.updateClient().then(
                                              (value) => value == true
                                                  ? Navigator.pop(context)
                                                  : null);
                                        }

                                        viewModel.saveClient().then((value) =>
                                            value == true
                                                ? Navigator.pop(context)
                                                : null);
                                      }
                                    : () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }

  // Método auxiliar para construir los TextFields
  Widget _buildTextField(String label, double width) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.dmSans(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: width * 0.035, // Tamaño de texto responsivo
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.004201681);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.004201681);
    path_0.cubicTo(
        size.width * 0.7737815,
        size.height * 0.004201681,
        size.width * 0.9957983,
        size.height * 0.2262185,
        size.width * 0.9957983,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.9957983, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9957983,
        size.height * 0.7737815,
        size.width * 0.7737815,
        size.height * 0.9957983,
        size.width * 0.5000000,
        size.height * 0.9957983);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.9957983);
    path_0.cubicTo(
        size.width * 0.2262185,
        size.height * 0.9957983,
        size.width * 0.004201681,
        size.height * 0.7737815,
        size.width * 0.004201681,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.004201681, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.004201681,
        size.height * 0.2262185,
        size.width * 0.2262185,
        size.height * 0.004201681,
        size.width * 0.5000000,
        size.height * 0.004201681);
    path_0.close();

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint_0_stroke.color = Color(0xffe4f353).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color.fromRGBO(255, 255, 255, .75).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
