import 'package:template/source/export.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static const splashPage = '/splashPage';
  static const homePage = '/homePage';
  static const loginPage = '/loginPage';
  static const loginEmail = '/loginEmail';
  static const createAccount = '/createAccount';
  static const myLocation = '/myLocation';
  static const detailFood = '/detailFood';
  static const searchPage = '/searchPage';
  static const dealPage = '/dealPage';
  static const loginOrRegister = '/loginOrRegister';
  static const forgotPassword = '/forgotPassword';
  static const editAccount = '/editAccount';
  static const myOrders = '/myOrders';
  static const paymentMethods = '/paymentMethods';
  static const myReviews = '/myReviews';
  static const detailHistoryOrder = '/detailHistoryOrder';
  static const checkOut = '/checkOut';
  static const orderComplete = '/orderComplete';
  static const addCart = '/addCart';
  static const otp = '/otp';

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case loginEmail:
        return MaterialPageRoute(builder: (_) => const LoginEmail());
      case createAccount:
        return MaterialPageRoute(builder: (_) => const CreateAccount());
      case myLocation:
        return MaterialPageRoute(builder: (_) => const MyLocation());
      case otp:
        final args = settings.arguments as Otp;
        return MaterialPageRoute(builder: (_) => Otp(email: args.email));
      case detailFood:
        final args = settings.arguments as DetailFood;
        return MaterialPageRoute(
            builder: (_) => DetailFood(
                foodItems: args.foodItems, restaurant: args.restaurant));
      case searchPage:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case dealPage:
        final args = settings.arguments as DealsPage;
        return MaterialPageRoute(
            builder: (_) => DealsPage(restaurant: args.restaurant));
      case loginOrRegister:
        final args = settings.arguments as LoginOrRegister;
        return MaterialPageRoute(
            builder: (_) => LoginOrRegister(index: args.index));
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case editAccount:
        return MaterialPageRoute(builder: (_) => const EditAccount());
      case myOrders:
        return MaterialPageRoute(builder: (_) => const MyOrders());
      case paymentMethods:
        return MaterialPageRoute(builder: (_) => const PaymentMethods());
      case myReviews:
        return MaterialPageRoute(builder: (_) => const MyReviews());
      case detailHistoryOrder:
        final args = settings.arguments as DetailHistoryOrder;
        return MaterialPageRoute(
            builder: (_) => DetailHistoryOrder(res: args.res));
      case checkOut:
        final args = settings.arguments as CheckOut;
        return MaterialPageRoute(
            builder: (_) => CheckOut(
                subPrice: args.subPrice,
                deliveryFee: args.deliveryFee,
                vat: args.vat,
                coupon: args.coupon,
                totalPrice: args.totalPrice));
      case orderComplete:
        return MaterialPageRoute(builder: (_) => const OrderComplete());
      case addCart:
        return MaterialPageRoute(builder: (_) => const AddCart());
      default:
        return errorRoute();
    }
  }

  static MaterialPageRoute<dynamic> errorRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            ));
  }
}
