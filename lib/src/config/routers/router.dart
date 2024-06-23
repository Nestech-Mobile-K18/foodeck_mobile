import 'package:template/src/pages/export.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/pages/find_current_location_page.dart';
import 'package:template/src/pages/no_network.dart';

class RouteName {
  static const splash = '/';
  static const login = '/login';
  static const createAccount = '/create-account';
  static const otp = '/otp';
  static const map = '/map';
  static const home = '/home';
  static const loginEmail = '/login-email';
  static const signup = '/sign-up';
  static const restaurant = '/restaurant';
  static const orderInfo = '/order-info';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const checkoutWait = '/checkout-wait';
  static const editAccount = '/edit-account';
  static const myLocation = '/my-location';
  static const history = '/history';
  static const paymentMethod = '/payment-method';
  static const review = '/review';
  static const aboutUs = '/about-us';
  static const billDetail = '/bill-detail';
  static const addLocation = '/add-location';
  static const getCurrentLocation = '/get-current-location';
  static const noInternet = '/no-internet';

  static const publicRoutes = [
    splash,
    login,
    createAccount,
    otp,
    map,
    home,
    loginEmail,
    signup,
    restaurant,
    orderInfo,
    cart,
    checkout,
    checkoutWait,
    editAccount,
    myLocation,
    history,
    paymentMethod,
    review,
    aboutUs,
    billDetail,
    addLocation,
    getCurrentLocation,
    noInternet
  ];
}

final router = GoRouter(
  redirect: (context, state) {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }

    return RouteName.splash;
  },
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: RouteName.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouteName.loginEmail,
      builder: (context, state) => const LoginEmailPage(),
    ),
    GoRoute(
      path: RouteName.signup,
      builder: (context, state) => const CreateAccountPage(),
    ),
    GoRoute(
      path: RouteName.createAccount,
      builder: (context, state) => const CreateAccountPage(),
    ),
    GoRoute(
      path: RouteName.otp,
      builder: (context, state) {
        Map<String, String> args = state.extra as Map<String, String>;
        final email = args['email'];
        return Otp(email: email);
      },
    ),
    GoRoute(
      path: RouteName.map,
      builder: (context, state) => const MapBoxPage(),
    ),
    GoRoute(
      path: RouteName.checkoutWait,
      builder: (context, state) => const WaitCheckout(),
    ),
    GoRoute(
      path: RouteName.restaurant,
      builder: (context, state) {
        print('state state ${ state.extra }');
      Map<String, Object?> args = state.extra as Map<String, Object?>;
      final id = args['id'].toString();
      final nameRestaurant = args['nameRestaurant'].toString();
      final nameAddress = args['nameAddress'].toString();
      final rate = args['rate'].toString();
      final time = args['time'].toString();
      final timeUnit = args['timeUnit'].toString();
      final distance = args['distance'].toString();
      final String disUnit = args['disUnit'].toString();
      final image = args['image'].toString();

      return
      //  EditAccountPage();
      
      RestaurantPage(
        id: int.parse(id),
        disUnit: disUnit,
        distance: double.parse(distance),
        nameAddress: nameAddress,
        nameRestaurant: nameRestaurant,
        rate: double.parse(rate),
        time: int.parse(time),
        timeUnit: timeUnit,
        image: image,
      );
    } ,
      
    ),
    GoRoute(
      path: RouteName.cart,
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: RouteName.editAccount,
      builder: (context, state) => const EditAccountPage(),
    ),
    GoRoute(
      path: RouteName.myLocation,
      builder: (context, state) => const LocationsPage(),
    ),
    GoRoute(
      path: RouteName.history,
      builder: (context, state) => const HistoryPage(),
    ),
    GoRoute(
      path: RouteName.paymentMethod,
      builder: (context, state) => const PaymentMethodPage(),
    ),
    GoRoute(
      path: RouteName.review,
      builder: (context, state) => const ReviewPage(),
    ),
    GoRoute(
      path: RouteName.aboutUs,
      builder: (context, state) => const AboutUsPage(),
    ),
    GoRoute(
      path: RouteName.addLocation,
      builder: (context, state) => const AddLocation(),
    ),
    GoRoute(
      path: RouteName.getCurrentLocation,
      builder: (context, state) => const FindCurrentLocationPage(),
    ),
    GoRoute(
      path: RouteName.noInternet,
      builder: (context, state) => const NoNetworkPage(),
    ),
  ],
);
