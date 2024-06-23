part of 'network_bloc.dart';

sealed class NetworkState {}

class NetworkInitial extends NetworkState {}

class NetworkSuccess extends NetworkState {}

class NetworkFailure extends NetworkState {}

