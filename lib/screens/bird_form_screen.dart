import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/bird.dart';
import '../providers/bird_provider.dart';

class BirdFormScreen extends StatefulWidget {
  final Bird? bird; // If null, creating new bird; if not null, editing existing bird

  const BirdFormScreen({super.key, this.bird});

  @override
  State<BirdFormScreen> createState() => _BirdFormScreenState();
}

class _BirdFormScreenState extends State<BirdFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _myanmarNameController;
  late TextEditingController _englishNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imagePathController;

  bool get isEditing => widget.bird != null;

  @override
  void initState() {
    super.initState();
    _myanmarNameController = TextEditingController(
      text: widget.bird?.birdMyanmarName ?? '',
    );
    _englishNameController = TextEditingController(
      text: widget.bird?.birdEnglishName ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.bird?.description ?? '',
    );
    _imagePathController = TextEditingController(
      text: widget.bird?.imagePath ?? 'img/birds/img/default.jpg',
    );
  }

  @override
  void dispose() {
    _myanmarNameController.dispose();
    _englishNameController.dispose();
    _descriptionController.dispose();
    _imagePathController.dispose();
    super.dispose();
  }

  Future<void> _saveBird() async {
    if (_formKey.currentState!.validate()) {
      final birdProvider = Provider.of<BirdProvider>(context, listen: false);

      final bird = Bird(
        id: widget.bird?.id ?? 0, // ID will be assigned by server for new birds
        birdMyanmarName: _myanmarNameController.text,
        birdEnglishName: _englishNameController.text,
        description: _descriptionController.text,
        imagePath: _imagePathController.text,
      );

      bool success;
      if (isEditing) {
        success = await birdProvider.updateBird(widget.bird!.id, bird);
      } else {
        success = await birdProvider.createBird(bird);
      }

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditing
                    ? 'Bird updated successfully'
                    : 'Bird created successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                birdProvider.errorMessage ?? 'Failed to save bird',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Bird' : 'Add New Bird'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // English Name
              TextFormField(
                controller: _englishNameController,
                decoration: const InputDecoration(
                  labelText: 'English Name *',
                  hintText: 'e.g., Orange-bellied Leafbird',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.translate),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter English name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Myanmar Name
              TextFormField(
                controller: _myanmarNameController,
                decoration: const InputDecoration(
                  labelText: 'Myanmar Name *',
                  hintText: 'e.g., ငှက်စိမ်းရင်ဝါ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.language),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Myanmar name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Enter bird description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Image Path
              TextFormField(
                controller: _imagePathController,
                decoration: const InputDecoration(
                  labelText: 'Image Path *',
                  hintText: 'e.g., img/birds/img/bird.jpg',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter image path';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Save Button
              Consumer<BirdProvider>(
                builder: (context, birdProvider, child) {
                  return ElevatedButton(
                    onPressed: birdProvider.isLoading ? null : _saveBird,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: birdProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text(isEditing ? 'Update Bird' : 'Create Bird'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

