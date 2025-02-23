import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/core/image_constants.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/services/home_services.dart';
import '../models/property.dart';

class HomeViewModel extends StateNotifier<HomeViewModelState> {
  HomeViewModel() : super(HomeViewModelState()) {
    _loadDummyData(); // Loads dummy data on initialization
  }

  void toggleBuy(bool isBuying) {
    state = state.copyWith(isBuying: isBuying);
  }

  void _loadDummyData() {
    // List<Property> dummyProperties = [
    //   Property(
    //     id: 1,
    //     name: "Luxury Apartment",
    //     location: "Gladvoka St., 25",
    //     price: 150000,
    //     latitude: 6.4281,
    //     longitude: 3.4215,
    //     imageUrl: ImageConstants.interiorOne,
    //   ),
    //   Property(
    //     id: 2,
    //     name: "Cozy Bungalow",
    //     location: "Ibadan, Oyo",
    //     price: 80000,
    //     latitude: 7.3775,
    //     longitude: 3.9470,
    //     imageUrl: "https://example.com/bungalow.jpg",
    //   ),
    //   Property(
    //     id: 3,
    //     name: "Beachfront Villa",
    //     location: "VI, Lagos",
    //     price: 300000,
    //     latitude: 6.4310,
    //     longitude: 3.4158,
    //     imageUrl: "https://example.com/villa.jpg",
    //   ),
    //   Property(
    //     id: 4,
    //     name: "Modern Duplex",
    //     location: "Abuja",
    //     price: 250000,
    //     latitude: 9.0579,
    //     longitude: 7.4951,
    //     imageUrl: "https://example.com/duplex.jpg",
    //   ),
    // ];

    List<Property> dummyOfferCards = [
      Property(
        id: 1,
        name: "Mini Flat",
        location: "Gladvoka St., 25",
        price: 50000,
        latitude: 6.5000,
        longitude: 3.3500,
        imageUrl: ImageConstants.interiorTwo,
      ),
      Property(
        id: 2,
        name: "Penthouse",
        location: "Trefoleva St., 23",
        price: 500000,
        latitude: 6.4500,
        longitude: 3.4000,
        imageUrl: ImageConstants.interiorThree,
      ),
      Property(
        id: 3,
        name: "Luxury Apartment",
        location: "Gladvoka St., 25",
        price: 150000,
        latitude: 6.4281,
        longitude: 3.4215,
        imageUrl: ImageConstants.interiorOne,
      ),
      Property(
        id: 4,
        name: "Cozy Bungalow",
        location: "Ibadan, Oyo",
        price: 80000,
        latitude: 7.3775,
        longitude: 3.9470,
        imageUrl: ImageConstants.interiorThree,
      ),
    ];

    state = state.copyWith(
      //properties: dummyProperties,
      offerCards: dummyOfferCards,
      buyCount: 2,
      rentCount: 4,
    );
  }
}

// Provide access to the ViewModel
final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeViewModelState>(
  (ref) => HomeViewModel(),
);
