import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';

class SearchInput extends StatelessWidget {

  final TextEditingController searchController;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final VoidCallback accion;

  const SearchInput({
    super.key,
    required this.searchController,
    this.prefixIcon = Icons.search,
    this.suffixIcon = Icons.location_searching_outlined,
    required this.accion,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(prefixIcon),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 20,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          // child: IconButton(
          //   icon: Icon(suffixIcon),
          //   onPressed: accion,
          // ),
          child: FilledButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.6),
            ),
            icon:Icon(suffixIcon),
            onPressed: () {}, 
            label: const Text("Detectar")
          ),
        ),
        hintText: 'Escribe aquí',
        prefixIconConstraints: const BoxConstraints(
          minWidth: 60,
        ),
        fillColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.6),
        filled: true,
        contentPadding: const EdgeInsets.all(kDefaultPadding/1.2),
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