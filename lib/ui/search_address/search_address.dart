
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:wl_delivery/ui/search_address/search_address_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/ui/search_address/search_address_state.dart';

class SearchAddressPage extends StatefulWidget {
  @override
  _SearchAddressPageState createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> with TickerProviderStateMixin {
  FloatingSearchBarController controller = FloatingSearchBarController();
  // Completer<GoogleMapController> _controller = Completer();
  late LatLng lastMapPosition;

  late Animation _translateAnimation;
  late AnimationController _translateAnimationController;

  @override
  void initState() {
    super.initState();
    _translateAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _translateAnimation = Tween(begin: Offset.zero, end: Offset(0, -5)).animate(_translateAnimationController);
  }

  Widget build(BuildContext context) {

    final SearchAddressCubit cubit = BlocProvider.of(context);
    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: BlocBuilder<SearchAddressCubit, SearchAddressState>(
        builder: (context, state) {

      controller.query = state.searchField;

      late CameraPosition cameraPosition;
      if (state.showMap) {
        cameraPosition = CameraPosition(
          target: LatLng(state.latitude!, state.longitude!),
          zoom: 16,
          );
      }
      return FloatingSearchAppBar(
        transitionDuration: const Duration(milliseconds: 800),
        color: Colors.white,
        colorOnScroll: Colors.white,
        elevation: 4,
        alwaysOpened: true,
        textInputType: TextInputType.streetAddress,
        hideKeyboardOnDownScroll: false,
        debounceDelay: Duration(milliseconds: 600),
        hint: "Search for location",
        controller: controller,
        onQueryChanged: cubit.search,
        autocorrect: false,
        actions: [IconButton(icon: Icon(Icons.clear), onPressed: cubit.clear), TextButton(onPressed: cubit.save, child: Text('Done', style: TextStyle(color: Colors.black),))],
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  final name = state.list[index].nameValue();
                  final areaName = state.list[index].areaNameValue();
                  final icon = state.list[index].icon();
                  return Card(
                    child: ListTile(
                      title: Text('$name'),
                      subtitle: areaName != null ? Text('$areaName') : null,
                      onTap: (() {
                        if (index == 0) {
                          cubit.selectMyLocation();
                        } else {
                          cubit.selectLocation((state.list[index] as Address).item);
                        }
                      }),
                      enableFeedback: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      minLeadingWidth: 16,
                      leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                            maxWidth: 20,
                            maxHeight: 20,
                          ),
                          child: Icon(icon)),
                    ),
                  );
                },
              ),
            ),
            if (state.showMap)
              Container(
                height: 300,
                child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: cameraPosition,
                      myLocationEnabled: true,
                      onCameraMove: (cameraPosition) {
                        lastMapPosition = cameraPosition.target;
                      },
                      onCameraMoveStarted: () => _translateAnimationController.forward(),
                      onCameraIdle: () async {
                        cubit.changeMapLocation(lastMapPosition.latitude, lastMapPosition.longitude);
                        _translateAnimationController.reverse();
                      },
                    ),
                    Center(
                        child: AnimatedBuilder(
                          animation: _translateAnimationController,
                          builder: (context, child) => Transform.translate(
                            offset: _translateAnimation.value,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                              child: Icon(Icons.push_pin),
                            )
                          ),
                        ),
                    ),
                    Center(
                      child: Container(
                        height: 5,
                        width: 5,
                          decoration: ShapeDecoration(
                              color: Colors.black45,
                              shape: StadiumBorder(),
                          ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      );
    }));
  }
}
