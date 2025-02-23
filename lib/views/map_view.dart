import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:ui' as ui;
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/core/app_colors.dart';

import '../widgets/search_bar.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  final LatLng _initialPosition = const LatLng(37.7749, -122.4194);
  final Set<Marker> _markers = {};
  String _mapStyle = '';
  final TextEditingController _searchController = TextEditingController();
  bool _isFilterVisible = false;
  IconData _selectedFilterIcon = Icons.filter_alt; // Default filter icon

  final Map<IconData, List<LatLng>> _filterLocations = {
    Icons.home: [
      LatLng(37.7749, -122.4194),
      LatLng(37.7849, -122.4094),
    ],
    Icons.attach_money: [
      LatLng(37.7649, -122.4294),
      LatLng(37.7549, -122.4394),
    ],
    Icons.business: [
      LatLng(37.7949, -122.3994),
      LatLng(37.7449, -122.4494),
    ],
  };

  final Map<IconData, List<String>> _filterPrices = {
    Icons.home: ["8.5 mn P", "6.95 mn P"],
    Icons.attach_money: ["13.3 mn P", "10.2 mn P"],
    Icons.business: ["12.0 mn P", "7.8 mn P"],
  };

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _updateMarkersForFilter(_selectedFilterIcon);
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_style.json');
    if (_mapController != null) {
      _mapController!.setMapStyle(_mapStyle);
    }
  }

  Future<BitmapDescriptor> _createCustomMarkerIcon(String text,
      {bool isPrice = false}) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()
      ..color = isPrice ? AppColors.primary : AppColors.primary;

    const double width = 100;
    const double height = 40;
    const double borderRadius = 8;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      const Radius.circular(borderRadius),
    );

    canvas.drawRRect(rect, paint);

    final iconPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    );

    iconPainter.layout();
    iconPainter.paint(canvas, const Offset(15, 10));

    final img = await pictureRecorder
        .endRecording()
        .toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<BitmapDescriptor> _createIconMarker(IconData icon) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()..color = AppColors.primary;

    const double size = 50;
    canvas.drawCircle(const Offset(size / 2, size / 2), size / 2, paint);

    final iconPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          fontSize: 24,
          color: AppColors.white,
        ),
      ),
    );

    iconPainter.layout();
    iconPainter.paint(
        canvas,
        Offset(
            (size - iconPainter.width) / 2, (size - iconPainter.height) / 2));

    final img = await pictureRecorder
        .endRecording()
        .toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  void _updateMarkersForFilter(IconData icon) async {
    _markers.clear();

    if (icon == Icons.layers_clear) {
      // All locations with price
      for (var entry in _filterLocations.entries) {
        for (int i = 0; i < entry.value.length; i++) {
          BitmapDescriptor iconMarker = await _createCustomMarkerIcon(
            _filterPrices[entry.key]![i],
            isPrice: true,
          );

          setState(() {
            _markers.add(Marker(
              markerId: MarkerId(_filterPrices[entry.key]![i]),
              position: entry.value[i],
              icon: iconMarker,
              infoWindow: InfoWindow(title: _filterPrices[entry.key]![i]),
            ));
          });
        }
      }
    } else if (icon == Icons.attach_money) {
      // Shows only price markers
      for (var entry in _filterLocations.entries) {
        for (int i = 0; i < entry.value.length; i++) {
          BitmapDescriptor iconMarker = await _createCustomMarkerIcon(
            _filterPrices[entry.key]![i],
            isPrice: true,
          );

          setState(() {
            _markers.add(Marker(
              markerId: MarkerId(_filterPrices[entry.key]![i]),
              position: entry.value[i],
              icon: iconMarker,
              infoWindow: InfoWindow(title: _filterPrices[entry.key]![i]),
            ));
          });
        }
      }
    } else {
      // Shows markers with selected filter icon (except price)
      List<LatLng>? locations = _filterLocations[icon];

      if (locations != null) {
        for (int i = 0; i < locations.length; i++) {
          BitmapDescriptor iconMarker = await _createIconMarker(icon);

          setState(() {
            _markers.add(Marker(
              markerId: MarkerId('$icon-$i'),
              position: locations[i],
              icon: iconMarker,
              infoWindow: InfoWindow(title: 'location'),
            ));
          });
        }
      }
    }
  }

  void _toggleFilterMenu() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  void _setFilter(IconData icon) {
    setState(() {
      _selectedFilterIcon = icon;
      _isFilterVisible = false;
      _updateMarkersForFilter(icon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 12),
            markers: _markers,
            onMapCreated: (controller) async {
              _mapController = controller;
              await _loadMapStyle();
            },
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: SearchBarWidget(
              controller: _searchController,
              onFilterPressed: _toggleFilterMenu,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 110,
            left: 20,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: _toggleFilterMenu,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(_selectedFilterIcon,
                        color: AppColors.white, size: 28),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.category, color: AppColors.white, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        "List of Variants",
                        style: GoogleFonts.dmSans(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isFilterVisible)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: _buildFilterMenu(),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterMenu() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _filterOption(Icons.home, "Cosy areas"),
          _filterOption(Icons.attach_money, "Price"),
          _filterOption(Icons.business, "Infrastructure"),
          _filterOption(Icons.layers_clear, "Without any layer"),
        ],
      ),
    );
  }

  Widget _filterOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon,
          color: _selectedFilterIcon == icon
              ? AppColors.primary
              : AppColors.white),
      title: Text(title, style: GoogleFonts.dmSans(color: AppColors.white)),
      onTap: () => _setFilter(icon),
    );
  }
}

mixin $_filterLocations {}
