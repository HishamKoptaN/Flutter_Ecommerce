import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _imagePath = '';

  Future<void> _uploadImage() async {
    // TODO: Implement image picker or file picker to select image
    setState(() {
      _imagePath =
          'path/to/selected/image.jpg'; // Replace with the actual path of the selected image
    });
  }

  Future<void> _addProduct() async {
    String productName = _productNameController.text.trim();
    double price = double.parse(_priceController.text.trim());

    // Upload the image to Firebase Storage
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('product_images')
        .child(_imagePath);
    UploadTask uploadTask = ref.putFile(File(_imagePath));
    TaskSnapshot storageTaskSnapshot =
        await uploadTask.whenComplete(() => null);
    String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

    // Add product details to Firestore
    await FirebaseFirestore.instance.collection('products').add(
      {
        'productName': productName,
        'price': price,
        'imageUrl': imageUrl,
      },
    );

    // Show success message or navigate back
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            _imagePath.isNotEmpty
                ? Image.file(File(_imagePath))
                : const Placeholder(fallbackHeight: 200.0),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addProduct,
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
