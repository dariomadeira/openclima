import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController searchController;
  final IconData prefixIcon;
  // final IconData suffixIcon;
  // final VoidCallback accion;
  final Function? onChanged;
  // final String buttonText;
  final Widget? suffixWidget;

  const SearchInput({
    super.key,
    required this.searchController,
    this.prefixIcon = Icons.search,
    // this.suffixIcon = Icons.location_searching_outlined,
    // required this.accion,
    this.onChanged,
    // this.buttonText = "Detectar",
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(prefixIcon),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 20,
        ),
        // suffixIcon: Padding(
        //   padding: const EdgeInsets.only(right: 10),
        //   child: FilledButton.icon(
        //     style: ElevatedButton.styleFrom(
        //       padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.6),
        //     ),
        //     icon:Icon(suffixIcon),
        //     onPressed: accion,
        //     label: Text(buttonText)
        //   ),
        // ),
        suffixIcon: suffixWidget,
        hintText: tr("input_search_hit"),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 60,
        ),
        fillColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.6),
        filled: true,
        contentPadding: EdgeInsets.all(kDefaultPadding / 1.2),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(kDefaultPadding * 2), // Bordes redondeados
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(kDefaultPadding * 2), // Bordes redondeados
        ),
      ),
    );
  }
}
