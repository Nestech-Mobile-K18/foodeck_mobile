import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/auth_manager.dart';
import '../models/payment.dart';
import 'dart:async';

class PaymentViewModel {
  final _supabase = Supabase.instance.client;

  Future<void> insertPaymentMethodNew(Payment paymentMethod) async {
    final String? userId = await AuthManager.getUserId();

    if (userId == null) {
      throw Exception('User ID not found');
    }

    Map<String, dynamic> paymentData = {
      'card_number': paymentMethod.cardNumber,
      'expiry_date': paymentMethod.expiryDate,
      'cvc': paymentMethod.cvc,
      'card_name': paymentMethod.cardName,
      'payment_method': paymentMethod.paymentMethod,
      'user_id': userId,
    };
    await _supabase.from('payment_method').insert(paymentData);
  }

  // Convert function getPaymentMethods to Stream
  Stream<List<Map<String, dynamic>>> getPaymentMethods() async* {
    final String? userId = await AuthManager.getUserId();

    if (userId == null) {
      yield [];
      return;
    }

    while (true) {
      final response =
          await _supabase.from('payment_method').select().eq('user_id', userId);

      final data = response;
      yield data.cast<Map<String, dynamic>>();
      await Future.delayed(
          const Duration(seconds: 5)); // Refresh every 5 seconds
    }
  }

  Future<List<Map<String, dynamic>>> getPaymentMethodsOnce() async {
    final String? userId = await AuthManager.getUserId();

    if (userId == null) {
      return [];
    }

    final response =
        await _supabase.from('payment_method').select().eq('user_id', userId);

    return response.cast<Map<String, dynamic>>();
  }

  Future<bool> isCardNumberExists(String cardNumber) async {
    final String? userId = await AuthManager.getUserId();

    if (userId == null) {
      throw Exception('User ID not found');
    }

    final response = await _supabase
        .from('payment_method')
        .select()
        .eq('user_id', userId)
        .eq('card_number', cardNumber);

    final data = response;
    return data.isNotEmpty;
  }

  Future<void> deletePaymentMethod(String cardNumber, String cvc) async {
    final String? userId = await AuthManager.getUserId();

    if (userId == null) {
      throw Exception('User ID not found');
    }

    final response = await _supabase
        .from('payment_method')
        .select()
        .eq('user_id', userId)
        .eq('card_number', cardNumber)
        .eq('cvc', cvc)
        .single();

    final id = response['id'];
    await _supabase.from('payment_method').delete().eq('id', id);
    }
}
