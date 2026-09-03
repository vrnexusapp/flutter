import 'package:flutter/material.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  bool _isLoading = false;
  String? _selectedFile;

  void _pickMedia(String type) async {
    setState(() => _isLoading = true);
    // Simulate picking delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
      _selectedFile = 'mock_${type}_file.png';
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected $type: $_selectedFile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File & Image Selection')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_selectedFile != null) ...[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.insert_drive_file, size: 64, color: Colors.blue),
                      const SizedBox(height: 16),
                      Text('Selected: $_selectedFile'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
              ElevatedButton.icon(
                onPressed: _isLoading ? null : () => _pickMedia('image'),
                icon: const Icon(Icons.image),
                label: const Text('Pick Image from Gallery'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : () => _pickMedia('camera'),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take a Photo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : () => _pickMedia('document'),
                icon: const Icon(Icons.file_copy),
                label: const Text('Pick Document'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
