import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/presentation/customer_details/pages/customer_details.dart';
import 'package:menu_servex/presentation/home/pages/home_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  final MobileScannerController _cameraController = MobileScannerController(
  //   cameraResolution: size,
  // detectionSpeed: detectionSpeed,
  // detectionTimeoutMs: detectionTimeout,
  // formats: selectedFormats,
  // returnImage: returnImage,
  // torchEnabled: true,
  // invertImage: invertImage,
  // autoZoom: autoZoom,
  );
  bool _isScanCompleted = false;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _switchCamera() async {
  //   try {
  //     await _cameraController.switchCamera();
  //   } catch (e) {
  //     debugPrint('Switch camera error: $e');
  //   }
  // }

   @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  // Helper method to extract the table number from scanned string data
  Future<void> _extractTableNumber(String rawData) async {
    if (_isScanCompleted) return;
    
    setState(() {
      _isScanCompleted = true;
    });

    String tableNumber = '';

    // Example 1: If QR code data is just "table_12"
    if (rawData.contains('table_')) {
      tableNumber = rawData.split('_').last;
    } 
    // Example 2: If QR code data is a URL "https://myrestaurant.com"
    else if (rawData.contains('/table/')) {
      tableNumber = rawData.split('/table/').last;
    } 
    // Example 3: Fallback if the QR code simply holds the raw digit "12"
    else if (RegExp(r'^\d+$').hasMatch(rawData)) {
      tableNumber = rawData;
    }

    if (tableNumber.isNotEmpty) {
      try {
        await _cameraController.stop(); // Pause the camera stream
      } catch (e) {
        debugPrint('Camera stop error: $e');
      }
      _showSuccessDialog(tableNumber);
    } else {
      // Reset scanning capability if format does not match expected criteria
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Table QR Code format')),
      );
      setState(() {
        _isScanCompleted = false;
      });
    }
  }

  void _showSuccessDialog(String tableNum) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Table Identified'),
        content: Text('You are checked into Table Number: $tableNum'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close Dialog
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage(tableNum:tableNum),) ); // Return table number back to previous route
            },
            child: const Text('Proceed to Menu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true, 
      appBar: AppBar(title: const Text('Scan Table QR Code'),backgroundColor: Colors.transparent,foregroundColor: AppColors.bg,elevation: 0,),
      body: Stack(
        children: [
          MobileScanner(
            controller: _cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                final String? rawValue = barcode.rawValue;
                if (rawValue != null) {
                  _extractTableNumber(rawValue);
                  break; 
                }
              }
            },
          ),
          // Aesthetic alignment box overlay for user targeting
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.bg, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}