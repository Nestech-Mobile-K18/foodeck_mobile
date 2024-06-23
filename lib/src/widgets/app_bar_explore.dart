import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/features/location/bloc/location_bloc.dart';
import 'package:template/src/pages/export.dart';

class AppBarExplore extends StatefulWidget {
  const AppBarExplore(
      {Key? key, required this.controller, required this.focusNode})
      : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;
  @override
  _AppBarExploreState createState() => _AppBarExploreState();
}

class _AppBarExploreState extends State<AppBarExplore> {
  bool _isMounted = false; // Flag variable to track widget mount state
  
  @override
  void initState() {
    _isMounted = true; // Set the flag to true when the widget is mounted

    super.initState();
  }

  @override
  void dispose() {
    _isMounted = false; // Set the flag to false when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: ColorsGlobal.globalPink,
      toolbarHeight: AppSize.s80,
      // toolbarHeight: AppSize.s20,

      flexibleSpace: SafeArea(
        child: FlexibleSpaceBar(
          background: Image.asset(
            MediaRes.imgHome,
            fit: BoxFit.cover,
          ),
          expandedTitleScale: 1,
          centerTitle: true,
          titlePadding: EdgeInsets.zero,
          title: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                left: AppSize.s24,
                right: AppSize.s24,
                bottom: AppSize.s80,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.location_on,
                        color: ColorsGlobal.white,
                        size: AppSize.s17,
                      ),
                    ),
                    Flexible(
                      child: BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, state) {
                          if (state is CurrentLocationSuccess) {
                            final address = state.address;
                            return Text(
                              address.toString(), //hard code
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.location,
                            );
                          }

                          // Handle other states or return a default widget if needed
                          return Text('Loading...');
                        },
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: AppSize.s24,
                right: AppSize.s24,
                child: SearchItemBar(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                ),
              ),
            ],
          ),
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.2,
      pinned: true,
      automaticallyImplyLeading: false,
    );
  }
}
