import 'package:flutter/material.dart';
import 'package:flutter_test_tots/ui/shared/widgets/custom_button.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter_test_tots/app/core/utils/responsive_screen.dart';
import 'package:flutter_test_tots/ui/views/loading/loading_page_login.dart';

import '../../viewmodels/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = getUsableScreenDimension(context, ScreenDimension.width);
    final height = getUsableScreenDimension(context, ScreenDimension.height);

    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return model.isBusy
            ? const LoadingPage()
            : Scaffold(
                body: SingleChildScrollView(
                  child: SizedBox(
                    height: height + MediaQuery.of(context).viewPadding.top,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: -height * 0.049763003318,
                          left: width * 0.5358974359,
                          child: SizedBox(
                            height: height * 0.3613744076,
                            width: width * 0.7697179487,
                            child: OverflowBox(
                              maxHeight: height,
                              maxWidth: width,
                              child: Image.asset(
                                "assets/icons/icon1.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: height * 0.4502369668,
                          left: -width * 0.2025641026,
                          child: SizedBox(
                            height: height * 0.1718009479,
                            width: width * 0.3653589744,
                            child: OverflowBox(
                              maxHeight: height,
                              maxWidth: width,
                              child: Opacity(
                                opacity: 0.33,
                                child: Image.asset(
                                  "assets/icons/icon1.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: height * 0.8258293839,
                          child: SizedBox(
                            height: height * 0.3613744076,
                            width: width * 0.0512820513,
                            child: OverflowBox(
                              maxHeight: height,
                              maxWidth: width,
                              child: Opacity(
                                opacity: 0.3,
                                child: Image.asset(
                                  "assets/icons/icon1.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.1718009479),
                              Image.asset("assets/icons/titleminimal.png",
                                  width: width * 0.7230769231),
                              SizedBox(height: height * 0.0697630332),
                              Text(
                                "LOG IN",
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    letterSpacing: width * 0.0064102564,
                                    color: const Color(0xFF0D1111)
                                        .withOpacity(0.85)),
                              ),
                              SizedBox(height: height * 0.0402843602),
                              SizedBox(
                                width: width * 0.7564102564,
                                height: height * 0.0545023697,
                                child: TextField(
                                  onChanged: model.setEmail,
                                  decoration: InputDecoration(
                                    labelText: 'Mail',
                                    labelStyle: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: const Color(0xFF161B14)),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.0272511848),
                              SizedBox(
                                width: width * 0.7564102564,
                                height: height * 0.0545023697,
                                child: TextField(
                                  onChanged: model.setPassword,
                                  obscureText: !model.isPasswordVisible,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: const Color(0xFF151914)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          model.isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color(0xFFA3A9B1),
                                        ),
                                        onPressed: () {
                                          model.isPasswordVisible =
                                              !model.isPasswordVisible;
                                        },
                                      )),
                                ),
                              ),
                              SizedBox(height: height * 0.0616113744),
                              CustomButton(
                                height: height * 0.0616113744,
                                width: width * 0.7589743590,
                                title: 'LOG IN',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: width * 0.0012820513,
                                  color: const Color(0xFFA3A9B1),
                                ),
                                onPressed:
                                    model.isEnabled() ? model.login : () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
