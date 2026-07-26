import 'dart:io';
import 'package:flutter/material.dart';
import '../models/country_involvement.dart';
import '../services/product_analysis_service.dart';
import '../widgets/country_card.dart';
import '../widgets/loading_overlay.dart';
import 'home_screen.dart';

class ResultsScreen extends StatefulWidget {
  final String? barcode;
  final File? imageFile;

  const ResultsScreen({super.key, this.barcode, this.imageFile});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final ProductAnalysisService _service = ProductAnalysisService();
  AnalysisResult? _result;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _analyze();
  }

  Future<void> _analyze() async {
    try {
      AnalysisResult result;
      if (widget.barcode != null && widget.imageFile != null) {
        result = await _service.analyzeByBarcodeAndImage(
          barcode: widget.barcode!,
          imageFile: widget.imageFile!,
        );
      } else if (widget.barcode != null) {
        result = await _service.analyzeByBarcode(widget.barcode!);
      } else if (widget.imageFile != null) {
        result = await _service.analyzeByImage(widget.imageFile!);
      } else {
        throw Exception('No barcode or image provided');
      }

      setState(() {
        _result = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Result'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingOverlay();
    if (_error != null) return _buildError();
    if (_result == null) return const Center(child: Text('No result'));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_result!.product?.name != null)
            Text(
              _result!.product!.name!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          if (_result!.product?.brand != null)
            Text(
              _result!.product!.brand!,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          if (_result!.product?.barcode != null)
            Text(
              'Barcode: ${_result!.product!.barcode}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          const SizedBox(height: 24),
          const Text(
            'Country Involvement',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ..._result!.countries.map(
            (c) => CountryCard(country: c),
          ),
          const SizedBox(height: 24),
          if (_result!.benefitingCountry != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on, color: Colors.amber, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Benefiting Country',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          _result!.benefitingCountry!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (_result!.summary != null) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Analysis',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(_result!.summary!),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Analysis failed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _analyze();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
