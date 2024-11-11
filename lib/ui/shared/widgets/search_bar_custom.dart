import 'package:flutter/material.dart';
import 'package:flutter_test_tots/app/core/utils/responsive_screen.dart';

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({super.key, required this.onSearchChanged});

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
