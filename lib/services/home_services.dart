import '../models/property.dart';

class HomeViewModelState {
  final bool isBuying;
  final List<Property> properties;
  final int buyCount;
  final int rentCount;
  final List<Property> offerCards;

  HomeViewModelState({
    this.isBuying = true,
    this.properties = const [],
    this.buyCount = 0,
    this.rentCount = 0,
    this.offerCards = const [],
  });

  HomeViewModelState copyWith({
    bool? isBuying,
    List<Property>? properties,
    int? buyCount,
    int? rentCount,
    List<Property>? offerCards,
  }) {
    return HomeViewModelState(
      isBuying: isBuying ?? this.isBuying,
      properties: properties ?? this.properties,
      buyCount: buyCount ?? this.buyCount,
      rentCount: rentCount ?? this.rentCount,
      offerCards: offerCards ?? this.offerCards,
    );
  }
}
