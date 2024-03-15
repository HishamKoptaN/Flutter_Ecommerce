import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteButton extends StatefulWidget {
  final String productId;

  const FavoriteButton(IconData iconData,
      {super.key,
      required this.productId,
      required Color color,
      required int size,
      required int padding,
      required bool isOutLine});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.black54,
      ),
      onPressed: () {
        toggleFavorite(widget.productId);
      },
    );
  }

  Future<void> toggleFavorite(String productId) async {
    final DocumentReference productRef =
        FirebaseFirestore.instance.collection('Favorites').doc(productId);

    try {
      final DocumentSnapshot productSnapshot = await productRef.get();

      if (productSnapshot.exists) {
        final bool currentFavorite = productSnapshot['Favorite'];
        await productRef.update({'Favorite': !currentFavorite});
        setState(() {
          isFavorite = !currentFavorite;
        });
      } else {
        print('المنتج غير موجود في قاعدة البيانات');
      }
    } catch (e) {
      print('حدث خطأ أثناء تحديث القيمة: $e');
    }
  }
}
