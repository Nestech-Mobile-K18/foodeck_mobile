import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/auth_manager.dart';
import '../models/cart_item.dart';
import '../models/coupon.dart';
import '../models/food_item.dart';

class CartViewModel extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  List<CartItem> _cartItems = [];
  List<FoodItem> _proposedFoods = [];
  List<Coupon> _coupons = [];
  String? _selectedCouponCode;
  int? _selectedCouponValue;

  List<CartItem> get cartItems => _cartItems;

  List<FoodItem> get proposedFoods => _proposedFoods;

  List<Coupon> get coupons => _coupons;

  String? get selectedCouponCode => _selectedCouponCode;

  int? get selectedCouponValue => _selectedCouponValue;

  Future<void> requestShowListCart() async {
    final String? userId = await AuthManager.getUserId();
    if (userId != null) {
      final response = await supabase
          .from('cart')
          .select('id, list_cart')
          .eq('user_id', userId)
          .eq('is_order', false);

      final data = response;
      if (data.isNotEmpty) {
        List<CartItem> allCartItems = [];
        for (var record in data) {
          final cartId = record['id'];
          final listCartJson = record['list_cart'] as List;
          allCartItems.addAll(listCartJson.map((json) {
            var cartItem = CartItem.fromJson(json);
            cartItem = CartItem(
              cartId: cartId,
              // Gán cartId vào đây
              idFood: cartItem.idFood,
              foodName: cartItem.foodName,
              bonus: cartItem.bonus,
              imageFood: cartItem.imageFood,
              addressRestaurant: cartItem.addressRestaurant,
              extraSauce: cartItem.extraSauce,
              variation: cartItem.variation,
              quantity: cartItem.quantity,
              price: cartItem.price,
              instructions: cartItem.instructions,
              userEmail: cartItem.userEmail,
              userPhone: cartItem.userPhone,
              userName: cartItem.userName,
            );
            return cartItem;
          }).toList());
        }
        _cartItems = allCartItems;
        notifyListeners();
      }
    }
  }

  Future<void> removeItemFromCart(String itemId) async {
    final String? userId = await AuthManager.getUserId();
    if (userId != null) {
      _cartItems.removeWhere((item) => item.idFood == itemId);
      await supabase.from('cart').update({
        'list_cart': _cartItems.map((item) => item.toJson()).toList()
      }).eq('user_id', userId);
      notifyListeners();
    }
  }

  Future<void> getProposedFoods() async {
    final res = await supabase.from('food').select().eq('propose', true);
    final data = res;
    if (data.isNotEmpty) {
      List<FoodItem> proposedFoodItems = [];
      for (var item in data) {
        proposedFoodItems.add(FoodItem.fromJson(item));
      }
      _proposedFoods = proposedFoodItems;
      notifyListeners();
    }
  }

  Future<void> getCoupon() async {
    final res = await supabase.from('coupon').select().eq('status', true);
    final data = res;
    if (data.isNotEmpty) {
      List<Coupon> couponList = [];
      for (var item in data) {
        couponList.add(Coupon.fromJson(item));
      }
      _coupons = couponList;
      if (_coupons.isNotEmpty) {
        _selectedCouponCode = _coupons.first.code; // Set default coupon code
        _selectedCouponValue = _coupons.first.value;
      }
      notifyListeners();
    }
  }

  void selectCoupon(String couponCode, int couponValue) {
    _selectedCouponCode = couponCode;
    _selectedCouponValue = couponValue;
    notifyListeners();
  }

  double getDiscountedTotalPrice() {
    final totalPrice = getTotalPrice();
    if (_selectedCouponValue != null) {
      return totalPrice - _selectedCouponValue!;
    }
    return totalPrice;
  }

  double getTotalPrice() {
    return _cartItems.fold(0.0, (sum, item) => sum + (item.price ?? 0));
  }

  void destroy() {
    _cartItems = [];
    _proposedFoods = [];
    _coupons = [];
    _selectedCouponCode = null;
    _selectedCouponValue = null;
  }
}
