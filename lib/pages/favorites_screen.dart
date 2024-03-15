import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../constants/app_colors.dart';
import '../features/firestore_services.dart';

FirestoreServices firestoreServices = FirestoreServices();

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class ProductModel {
  String name;
  double price;
  bool isFavorite;

  ProductModel({
    required this.name,
    required this.price,
    this.isFavorite = false,
  });
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Card(
            child: Text(
              'My Favorites',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border:
              Border.all(color: AppColors.iconColor, style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Colors.transparent,
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color(0xfff8f8f8),
                blurRadius: 5,
                spreadRadius: 10,
                offset: Offset(5, 5)),
          ],
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('Favorite', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // عدد الأعمدة في الشبكة
                      crossAxisSpacing: 8.0, // المسافة الأفقية بين العناصر
                      mainAxisSpacing: 8.0, // المسافة العمودية بين العناصر
                    ),
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, i) {
                      List products = snapshots.data!.docs;
                      var data = snapshots.data!.docs[i].data()
                          as Map<String, dynamic>;
                      DocumentSnapshot document = products[i];
                      document.id;
                      String url = data['Image'];
                      return Container(
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                fieldImage(url),
                                Positioned(
                                  top: 0,
                                  right: 80,
                                  child: GestureDetector(
                                    onTap: () {
                                      updateFavoriteStatusInFirestore(
                                          !data['favorite_products'],
                                          document.id);
                                    },
                                    child: Icon(
                                      data['favorite_products']
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: data['favorite_products']
                                          ? Colors.red
                                          : Colors.black54,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: fieldImage(url),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  fieldName(data),
                                  fieldPrice(data),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  void updateFavoriteStatusInFirestore(
      bool newFavoriteStatus, String productId) async {
    try {
      final DocumentReference productRef =
          FirebaseFirestore.instance.collection('products').doc(productId);

      await productRef.update({'favorite_products': newFavoriteStatus});

      // قم بتحديث واجهة المستخدم لعرض التغيير الجديد إذا كنت بحاجة إلى ذلك
      // يمكنك تحديث الحالة المحلية أو إعادة تحميل البيانات إذا كنت تستخدم StatefulWidget
    } catch (e) {
      print('حدث خطأ أثناء تحديث الحالة: $e');
    }
  }
}

ImageNetwork fieldImage(String url) {
  return ImageNetwork(
    image: url, // Required image url
    width: 60,
    height: 50,
    fitAndroidIos: BoxFit.cover,
  );
}

Text fieldName(Map<String, dynamic> data) {
  return Text(
    data['product_name'],
    style: const TextStyle(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text fieldSize(Map<String, dynamic> data) {
  return Text(
    data['Size'],
    style: const TextStyle(
      color: Colors.black54,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text fieldPrice(Map<String, dynamic> data) {
  return Text(
    ('\$ ' + data['product_price']),
    style: const TextStyle(
      color: Colors.black54,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  );
}
