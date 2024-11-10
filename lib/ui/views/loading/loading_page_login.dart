import 'package:flutter/material.dart';
import 'package:flutter_test_tots/app/core/utils/responsive_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController animationControllerImage;
  late List<AnimationController> animationControllers;

  late Animation<double> animationImage;
  late Animation<double> animationImageTwo;
  late Animation<double> opacityAnimation;
  late List<Animation<double>> animations;

  late bool shouldReverse; // Variable para controlar la reversa

  @override
  void initState() {
    super.initState();

    animationControllerImage = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1050),
      reverseDuration: const Duration(milliseconds: 1050),
    )..repeat(reverse: true);

    animationImage = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 1, end: 0.88), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 0.88, end: 0.88), weight: 30)
    ]).animate(animationControllerImage);

    animationControllers = List.generate(
        10,
        (index) => AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 250),
              reverseDuration: const Duration(milliseconds: 250),
            ));

    animations = animationControllers.map((controller) {
      // Crear una animación para cada esfera usando el respectivo controlador
      return Tween<double>(begin: 0, end: 0.117370892).animate(
          CurvedAnimation(parent: controller, curve: Curves.decelerate));
    }).toList();

    shouldReverse = false; // Inicialmente no se debe hacer reversa

    // Iniciar las animaciones con delays progresivos
    for (int i = 0; i < animationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 80), () {
        animationControllers[i].forward(); // Repetir la animación
      });
    }

    // Escuchar el cambio de status de los controladores
    animationControllers[animationControllers.length - 3]
        .addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Si el último controlador completa su animación y se debe hacer reversa
        for (int i = 0; i < animationControllers.length; i++) {
          Future.delayed(Duration(milliseconds: i * 80), () {
            animationControllers[i].reverse(); // Repetir la animación
          });
        }
        shouldReverse = false; // Reiniciar la bandera
      }
    });

    // Escuchar el cambio de status del primer controlador
    animationControllers[animationControllers.length - 3]
        .addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        // Cuando el primer controlador llega al inicio, marcar para hacer reversa
        for (int i = 0; i < animationControllers.length; i++) {
          Future.delayed(Duration(milliseconds: i * 80), () {
            animationControllers[i].forward(); // Repetir la animación
          });
        }
      }
    });
  }

  @override
  void dispose() {
    for (var animationController in animationControllers) {
      animationController.dispose();
    }
    animationControllerImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = getUsableScreenDimension(context, ScreenDimension.width);
    final height = getUsableScreenDimension(context, ScreenDimension.height);

    final theme = Theme.of(context);

    MediaQuery.viewPaddingOf(context).top;

    return Scaffold(
      backgroundColor:
          theme.colorScheme.surfaceContainerLowest.withOpacity(0.92),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: height * 0.3039906103,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: SizedBox(
                    width: width * 0.4830917874,
                    height: height * 0.2347417840,
                    child: Stack(
                      alignment: Alignment.center,
                      children: List.generate(
                        10,
                        (index) => AnimatedBuilder(
                            animation: animationControllers[index],
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: 0.628319 * index,
                                child: Transform.translate(
                                    offset: Offset(
                                        0, -height * animations[index].value),
                                    child: const Circle()),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    AnimatedBuilder(
                        animation: animationControllerImage,
                        builder: (context, child) {
                          return SizedBox(
                            width: width * 0.4830917874,
                            height: height * 0.2347417840,
                          );
                        }),
                    SizedBox(height: height * 0.05342723),
                    Text(
                      "Cargando...",
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: width * 0.0064102564,
                          color: const Color(0xFF0D1111).withOpacity(0.85)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = getUsableScreenDimension(context, ScreenDimension.width);

    final theme = Theme.of(context);
    return Transform.translate(
      offset: const Offset(0, 0),
      child: Container(
        height: width * 0.0323091787,
        width: width * 0.0323091787,
        decoration: BoxDecoration(
            color: theme.colorScheme.primary, shape: BoxShape.circle),
      ),
    );
  }
}
