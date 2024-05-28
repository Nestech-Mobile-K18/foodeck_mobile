import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/api.dart';
import '../../../services/auth_manager.dart';
import '../../../services/mapbox_config.dart';
import '../../../services/table_supbase.dart';
import '../../cart/models/cart_item.dart';

class CheckOutViewModel extends ChangeNotifier {
  final API _api = API();
  final _supabase = Supabase.instance.client;
  static const String _baseUrl = MapBoxConfig.BASE_URL_MAPBOX;
  static const String _apiKey = MapBoxConfig.MAPBOX_ACCESS_TOKEN;

  final _userDataController = StreamController<Map<String, dynamic>?>();
  final _paymentMethodsController =
      StreamController<List<Map<String, dynamic>>>();

  CheckOutViewModel() {
    fetchUserData();
    fetchPaymentMethods();
  }

  Stream<Map<String, dynamic>?> get userDataStream =>
      _userDataController.stream;

  Stream<List<Map<String, dynamic>>> get paymentMethodsStream =>
      _paymentMethodsController.stream;

  void fetchUserData() async {
    final String? getUserId = await AuthManager.getUserId();
    if (getUserId == null) {
      _userDataController.add(null);
      return;
    }

    var locationColumns = [
      TableSupabase.addressColumn1,
      TableSupabase.addressColumn2,
      TableSupabase.addressColumn3,
      TableSupabase.addressColumn4,
      TableSupabase.addressColumn5
    ];
    var userResponse;
    Map<String, String?> addressResponse = {};

    for (var addressColumn in locationColumns) {
      var response = await _api.supabase
          .from(TableSupabase.localUserTable)
          .select(addressColumn)
          .eq(TableSupabase.userIdColumn, getUserId)
          .single();

      var address = response[addressColumn] as String?;
      if (address != null) {
        userResponse = await _api.supabase
            .from(TableSupabase.usersTable)
            .select('email, name, phone, password, avatar')
            .eq(TableSupabase.idColumn, getUserId)
            .single();
        addressResponse['address'] = address;
        break;
      }
    }

    if (userResponse == null) {
      _userDataController.add(null);
      return;
    }

    Map<String, dynamic> joinedData = joinMaps(userResponse, addressResponse);
    _userDataController.add(joinedData);
  }

  void fetchPaymentMethods() async {
    final String? userId = await AuthManager.getUserId();

    if (userId == null) {
      _paymentMethodsController.add([]);
      return;
    }

    final response =
        await _supabase.from('payment_method').select().eq('user_id', userId);

    final data = response;
    _paymentMethodsController.add(data.cast<Map<String, dynamic>>());
  }

  // Joins two maps into a single map.
  Map<String, dynamic> joinMaps(
      Map<String, dynamic> map1, Map<String, dynamic> map2) {
    Map<String, dynamic> result = {};
    result.addAll(map1);
    result.addAll(map2);
    return result;
  }

  Future<LatLng> getLatLngFromAddress(String? address) async {
    if (address == null || address.isEmpty) {
      throw Exception('Invalid address');
    }

    final response = await http.get(Uri.parse(
        '$_baseUrl/geocoding/v5/mapbox.places/${Uri.encodeComponent(address)}.json?access_token=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'].isNotEmpty) {
        final location = data['features'][0]['geometry']['coordinates'];
        return LatLng(location[1], location[0]);
      } else {
        throw Exception('No results found for the provided address');
      }
    } else {
      throw Exception('Failed to fetch coordinates');
    }
  }

  Future<void> addOrder(Map<String, dynamic> checkoutData, String address,
      String instructions, Map<String, dynamic> paymentMethod) async {
    final String? userId = await AuthManager.getUserId();
    if (userId == null) return;

    // Create order information
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);
    final String orderName = 'Order $formattedDate';
    const String status = 'Order received';

    // Prepare order information as JSON
    final Map<String, dynamic> informationOrder = {
      'address': address,
      'instructions': instructions,
      'payment_method': paymentMethod,
      'checkout_data': checkoutData,
    };


    final List<CartItem> cartItems = checkoutData['cartItems'];
    if (cartItems.isEmpty) {
      return; // or appropriate error handling
    }

    // Get the cartId from the first CartItem object
    final String? cartId = cartItems.first.cartId;

    if (cartId == null) {
      return;
    }

    // Check if the value "id_cart" exists in the table "cart".
    final cartResponse =
        await _supabase.from('cart').select().eq('id', cartId).single();

    // Get results from query
    final cartData = cartResponse;

    // Get the "id" value from the "cart" table and add it to the "order" table
    await _supabase.from('order').insert({
      'order_name': orderName,
      'status': status,
      'information_order': informationOrder,
      'id_cart': cartData['id'],
    });
    await _supabase.from('cart').update({'is_order': true}).eq('id', cartId);
  }

  @override
  void dispose() {
    _userDataController.close();
    _paymentMethodsController.close();
    super.dispose();
  }
}
