import 'package:flutter/material.dart';
import 'package:flutter_test_tots/app/app.router.dart';
import 'package:flutter_test_tots/app/core/utils/responsive_screen.dart';
import 'package:flutter_test_tots/ui/shared/widgets/card_client.dart';
import 'package:flutter_test_tots/ui/shared/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import '../../viewmodels/clients_viewmodel.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = getUsableScreenDimension(context, ScreenDimension.width);
    final height = getUsableScreenDimension(context, ScreenDimension.height);

    return ViewModelBuilder<ClientsViewModel>.reactive(
      viewModelBuilder: () => ClientsViewModel(),
      onViewModelReady: (viewModel) => viewModel.fetchClients(),
      builder: (context, viewModel, child) {
        if (viewModel.errorMessage != null) {
          return Center(child: Text(viewModel.errorMessage!));
        }
        return Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {}),
          body: SingleChildScrollView(
            child: SizedBox(
              height: height + MediaQuery.of(context).viewPadding.top,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -height * 0.3116113744 +
                        MediaQuery.of(context).viewPadding.top,
                    left: -width * 0.3256410256,
                    child: SizedBox(
                      height: height * 0.3619194313,
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
                    top: height * 0.2950236967,
                    left: width * 0.5102564103,
                    child: SizedBox(
                      height: height * 0.4983589744,
                      width: width * 0.4897435897,
                      child: OverflowBox(
                        maxHeight: (height * 0.4983589744) * 2,
                        maxWidth: (width * 0.48974358977) * 2,
                        child: Opacity(
                          opacity: 0.83,
                          child: Transform.scale(
                            scale: 0.8,
                            child: Image.asset(
                              "assets/icons/icon1.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.7630331754,
                    left: width * 0.3717948718,
                    child: SizedBox(
                      height: height * 0.3619194313,
                      width: width * 0.7697179487,
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
                  Positioned(
                    top: height * 0.8021327014,
                    left: -width * 0.2025641026,
                    child: SizedBox(
                      height: height * 0.1718009479,
                      width: width * 0.3653589744,
                      child: OverflowBox(
                        maxHeight: (height * 0.1718009479) * 2,
                        maxWidth: (width * 0.3653589744) * 2,
                        child: Opacity(
                          opacity: 0.33,
                          child: Image.asset(
                            "assets/icons/icon1.png",
                            // fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05897435897),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.04028436019),
                          Center(
                            child: Image.asset(
                              "assets/icons/titleminimal.png",
                              width: width * 0.3305641026,
                              height: height * 0.06398104265,
                            ),
                          ),
                          SizedBox(height: height * 0.0308056872),
                          Text(
                            "CLIENTS",
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: width * 0.0064102564,
                                color: const Color(0xFF434545)),
                          ),
                          SizedBox(height: height * 0.02843601896),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SearchBar(
                                onSearchChanged: viewModel.searchClients,
                              ),
                              CustomButton(
                                height: height * 0.03436018957,
                                width: width * 0.2384615385,
                                title: 'ADD NEW',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  letterSpacing: width * 0.001282051282,
                                  color: const Color(0xFFFFFFFF),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.01777251185),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRouter.clientDetailRoute);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.02132701422),
                          SizedBox(
                            height: height * 0.6090047393,
                            child: ListView.builder(
                              itemCount: viewModel.displayedClients.length,
                              itemBuilder: (context, index) {
                                final client =
                                    viewModel.displayedClients[index];

                                return CardClient(
                                  width: width,
                                  height: height,
                                  name:
                                      '${client.firstname ?? ''} ${client.lastname ?? ''}',
                                  email: client.email ?? "",
                                  image: client.photo,
                                );
                                // return Text(
                                //     '${client.firstname} ${client.lastname}');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Indicador de carga
                  if (viewModel.isBusy)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black54, // Fondo semitransparente
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),

                  Positioned(
                    bottom: height * 0.04265402844,
                    child: CustomButton(
                      height: height * 0.06161137441,
                      width: width * 0.758974359,
                      title: " LOAD MORE",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: width * 0.001282051282,
                        color: const Color(0xFFFFFFFF),
                      ),
                      onPressed: () {
                        viewModel.loadFiveClientsMore();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.onSearchChanged});

  final Function(String) onSearchChanged;

  @override
  Widget build(BuildContext context) {
    final width = getUsableScreenDimension(context, ScreenDimension.width);
    final height = getUsableScreenDimension(context, ScreenDimension.height);
    return SizedBox(
      width: width * 0.5564102564,
      height: height * 0.04265402844,
      child: TextField(
        onChanged: onSearchChanged,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          hintText: 'Search...',
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.62),
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF616060),
          ),
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(68),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(68),
            borderSide: const BorderSide(color: Color(0x9C1F1D2B), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(68),
            borderSide: const BorderSide(color: Color(0x9C1F1D2B), width: 1),
          ),
        ),
      ),
    );
  }
}
