import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class CommonUtils {
  static initializeLocationAndSave(BuildContext context) async {
    // Ensure all permissions are collected for Locations
    LocationPermission location;
    await Geolocator.isLocationServiceEnabled();

    location = await Geolocator.checkPermission();
    if (location == LocationPermission.denied) {
      location = await Geolocator.requestPermission();
    } else if (location == LocationPermission.unableToDetermine) {
      location = await Geolocator.requestPermission();
    } else if (location == LocationPermission.deniedForever) {
    } else {
      // Get capture the current user location
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
      final UserProvider userProvider = UserProvider();
      final data = await userProvider.getUser();
      if (data.isEmpty) {
        if (context.mounted) {
          AsyncFunctions.insertData(
              'users',
              {
                'address': '${place.street}, ${place.subAdministrativeArea}',
                'latitude': position.latitude,
                'longitude': position.longitude
              },
              PopUp.deny);
        }
      } else {
        if (context.mounted) {
          AsyncFunctions.updateData(
              'users',
              {
                'address': '${place.street}, ${place.subAdministrativeArea}',
                'latitude': position.latitude,
                'longitude': position.longitude
              },
              PopUp.deny);
        }
      }
    }
  }

  static authState() {
    supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.homePage);
      } else if (session == null) {
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.loginPage);
      }
    });
  }

  static validateInfoBeforeUpdate(ProfilePageUpdateInfoEvent event) {
    bool check1 = false;
    bool check2 = false;
    bool check3 = false;
    bool check4 = false;
    if (event.name == null ||
        event.name!.isEmpty &&
            event.email.isEmpty &&
            event.phone.isEmpty &&
            event.pass.isEmpty &&
            event.imageUrl == null) {
      customSnackBar(event.context, Toast.error, 'Nothing change');
    } else {
      if (event.name == null) {
        check1 = true;
      } else {
        check1 = false;
        if (Validation.nameRegex.hasMatch(event.name!)) {
          check1 = true;
        }
      }
      if (event.email.isEmpty) {
        check2 = true;
      } else {
        check2 = false;
        if (Validation.emailRegex.hasMatch(event.email)) {
          check2 = true;
        }
      }
      if (event.phone.isEmpty) {
        check3 = true;
      } else {
        check3 = false;
        if (event.phone.length == 10) {
          check3 = true;
        }
      }
      if (event.pass.isEmpty) {
        check4 = true;
      } else {
        check4 = false;
        if (Validation.passRegex.hasMatch(event.pass)) {
          check4 = true;
        }
      }
      if (event.imageUrl ==
              event.context.read<ProfilePageBloc>().imageUrlData ||
          event.imageUrl == null) {
      } else {
        AsyncFunctions.updateData(
            'users', {'avatar_url': event.imageUrl}, PopUp.deny);
      }

      if (check1 && check2 && check3 && check4) {
        if (event.name != null && event.name!.isNotEmpty) {
          AsyncFunctions.updateData(
              'users', {'full_name': event.name}, PopUp.deny);
        }
        if (event.email.isNotEmpty) {
          AsyncFunctions.updateData(
              'users', {'email': event.email}, PopUp.deny);
          AsyncFunctions.updateUser(event.email);
        }
        if (event.phone.isNotEmpty) {
          AsyncFunctions.updateData(
              'users', {'phone': event.phone}, PopUp.deny);
        }
        if (event.pass.isNotEmpty) {
          AsyncFunctions.updateData(
              'users', {'password': event.pass}, PopUp.deny);
          AsyncFunctions.updateUser(event.pass);
        }
        customSnackBar(
            event.context, Toast.success, 'You just updated profile');
      } else {
        customSnackBar(event.context, Toast.error, 'Error! Please retry');
      }
    }
  }

  static toggleLike(ExplorePageLikeState state, BuildContext context) {
    if (!SavedListData.saveFood.contains(state.restaurantModel)) {
      customSnackBar(context, Toast.error, 'You just unliked this item');
    } else {
      customSnackBar(context, Toast.success, 'You just liked this item');
    }
  }

  static logOut(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Are you sure want to logout?'),
        actions: [
          TextButton(
              onPressed: () {
                AsyncFunctions.logOut();
              },
              child: const CustomText(content: 'Yes', color: Colors.red)),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const CustomText(content: 'No', color: Colors.blue))
        ],
      ),
    );
  }

  static checkPageToNavigate(String index, BuildContext context) {
    switch (index) {
      case 'Edit Account':
        Navigator.pushNamed(context, AppRouter.editAccount);
        break;
      case 'My Locations':
        Navigator.pushNamed(context, AppRouter.myLocation);
        break;
      case 'My Orders':
        Navigator.pushNamed(context, AppRouter.myOrders);
        break;
      case 'Payment Methods':
        Navigator.pushNamed(context, AppRouter.paymentMethods);
        break;
      case 'My Reviews':
        Navigator.pushNamed(context, AppRouter.myReviews);
        break;
      case 'About Us':
        customSnackBar(context, Toast.error, 'In Updating...');
        break;
      case 'Data Usage':
        customSnackBar(context, Toast.error, 'In Updating...');
        break;
      case 'Light Mode':
        break;
      case 'Log Out':
        logOut(context);
        break;
    }
  }
}
