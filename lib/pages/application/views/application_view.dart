import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/pages/application/vm/application_view_model.dart';
import 'package:template/pages/home/view/home_view.dart';
import 'package:template/resources/const.dart';

import 'package:template/resources/export.dart';

import '../models/application_model.dart';
import '../widgets/build_pages.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationViewModel>(
      create: (context) => ApplicationViewModel(),
      child: Consumer<ApplicationViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            body: PageBuilder(index: viewModel.selectedIndex),
            bottomNavigationBar: Container(
              width: double.infinity,
              height: Responsive.screenHeight(context) * 0.12,
              decoration: BoxDecoration(
                color: ColorsGlobal.globalWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                  )
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: viewModel.selectedIndex,
                onTap: (index) {
                  viewModel.onItemTapped(index);
                },
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: viewModel.getColor(viewModel.selectedIndex),
                unselectedItemColor: ColorsGlobal.globalGrey,
                items: bottomTabs,
              ),
            ),
          );
        },
      ),
    );
  }
}
