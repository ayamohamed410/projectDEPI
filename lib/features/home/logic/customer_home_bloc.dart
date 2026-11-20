import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CustomerHomeEvent {
  const CustomerHomeEvent();
}

class LoadCustomerHome extends CustomerHomeEvent {
  const LoadCustomerHome();
}

class SearchHomeServices extends CustomerHomeEvent {
  final String query;
  const SearchHomeServices(this.query);
}

abstract class CustomerHomeState {
  const CustomerHomeState();
}

class CustomerHomeLoading extends CustomerHomeState {
  const CustomerHomeLoading();
}

class CustomerHomeLoaded extends CustomerHomeState {
  final String customerName;
  final String searchQuery;
  const CustomerHomeLoaded({required this.customerName, this.searchQuery = ''});
}

class CustomerHomeFailure extends CustomerHomeState {
  final String message;
  const CustomerHomeFailure(this.message);
}

class CustomerHomeBloc extends Bloc<CustomerHomeEvent, CustomerHomeState> {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  CustomerHomeBloc({required this.auth, required this.firestore})
      : super(const CustomerHomeLoading()) {
    on<LoadCustomerHome>((event, emit) async {
      emit(const CustomerHomeLoading());
      try {
        final user = auth.currentUser;
        if (user == null) {
          emit(const CustomerHomeFailure('Please sign in to view your home.'));
          return;
        }
        final doc = await firestore.collection('users').doc(user.uid).get();
        final name = (doc.data()?['name'] as String?)?.trim();
        if (name == null || name.isEmpty) {
          emit(const CustomerHomeFailure('Customer profile is missing.'));
          return;
        }
        emit(CustomerHomeLoaded(customerName: name));
      } catch (_) {
        emit(const CustomerHomeFailure('Could not load your profile. Check your connection and try again.'));
      }
    });
    on<SearchHomeServices>((event, emit) {
      final current = state;
      if (current is CustomerHomeLoaded) {
        emit(CustomerHomeLoaded(
          customerName: current.customerName,
          searchQuery: event.query,
        ));
      }
    });
  }
}
