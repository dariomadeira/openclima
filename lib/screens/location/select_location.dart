import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/config/helpers/colors_helper.dart';
import 'package:openclima/providers/geo_provider.dart';
import 'package:openclima/screens/widgets/inputs/search_input.dart';
import 'package:openclima/screens/widgets/states/loading_widget.dart';
import 'package:openclima/screens/widgets/tiles/custom_tile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  final TextEditingController searchController = TextEditingController();
  final colorsHelper = ColorsHelper();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final geoProvider = Provider.of<GeoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Busque su ubicación"),
      ),
      body: geoProvider.isLoading
          ? const Center(
              child: LoadingWidget(),
            )
          :Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
              width: 100.w,
              // height: 20.h,
              color: scaffoldBackgroundColor,
              child: SearchInput(
                  searchController: searchController,
                  accion: () {
                    geoProvider.getGeoLocation();
                  })),
          Expanded(
            child: SizedBox(
                width: 100.w,
                // color: Colors.red,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CustomTile(
                          title: "title $index",
                          subtitle: "subtitle $index",
                          icon: Icons.pin_drop_outlined,
                          noEllipsis: true,
                          color: colorsHelper.randomColor(),
                          showEdit: true,
                          editAccion: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                        // SizedBox(height: index == predictions.length - 1 ? kDefaultPadding : kDefaultPadding/2),
                        const SizedBox(height: kDefaultPadding),
                      ],
                    );
                  },
                )),
          ),
        ],
      ),

      // body: const Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      // SearchBar(hintText: 'Select Location'),
      //     RounderDetail(
      //       icon: Icons.location_on_outlined,
      //       color: Colors.indigo,
      //     ),
      //     RounderDetail(
      //       icon: Icons.location_searching_outlined,
      //       color: Colors.amber,
      //     ),
      //   ],
      // )
    );
  }
}
