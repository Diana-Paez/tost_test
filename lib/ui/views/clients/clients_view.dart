import 'package:flutter/material.dart';
import 'package:flutter_test_tots/ui/shared/widgets/search_bar_custom.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter_test_tots/app/app.router.dart';
import 'package:flutter_test_tots/app/core/utils/responsive_screen.dart';
import 'package:flutter_test_tots/ui/shared/widgets/card_client.dart';
import 'package:flutter_test_tots/ui/shared/widgets/custom_button.dart';

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
      fireOnViewModelReadyOnce: false,
      builder: (context, viewModel, child) {
        if (viewModel.errorMessage != null) {
          return Center(child: Text(viewModel.errorMessage!));
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: height +
                  MediaQuery.of(context).viewPadding.top +
                  MediaQuery.of(context).viewPadding.bottom,
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
                              SearchBarCustom(
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
                                onPressed: () async {
                                  final result = await Navigator.pushNamed(
                                      context, AppRouter.clientDetailRoute);
                                  if (result == true) {
                                    viewModel.fetchClients();
                                  }
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
                                  viewModel: viewModel,
                                  width: width,
                                  height: height,
                                  client: client,
                                  index: index,
                                  onPressed: () async {
                                    final result = await Navigator.pushNamed(
                                        context, AppRouter.clientDetailRoute,
                                        arguments: client);
                                    if (result == true) {
                                      viewModel.fetchClients();
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (viewModel.isBusy)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black54,
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
