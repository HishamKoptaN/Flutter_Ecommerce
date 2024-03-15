import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/horizontal_listview.dart';
import '../components/offers.dart';
import '../features/firebase_auth_services.dart';
import '../features/firestore_services.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // الأن تحديث حالة المفضلة على المستوى العالمي
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  TextEditingController searchcontroller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirestoreServices firestoreServices = FirestoreServices();
  var likes;
  String search = "";
  bool searchvisible = false;
  List<String> favorites = [];

  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  // تحديد معرف المستند الخاص بالمنتج عند الضغط على القائمة
  String? currentProductId;
  @override
  void initState() {
    super.initState();
    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.tune,
            color: Colors.green.shade600,
          ),
        ),
        title: SizedBox(
          width: 350,
          height: 30,
          child: TextFormField(
            obscureText: searchvisible,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Search field can`t be empty';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.green.shade600),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.green.shade600,
                  width: 1,
                ),
              ),
            ),
            onChanged: (val) {
              setState(() {
                search = val;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              FirebaseAuthService().signOut();
            },
            child: Text(
              'Search',
              style: TextStyle(
                color: Colors.green.shade600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Explore",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const Text(
            "best Outfits for you",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            child: HorizontalList(),
          ),
          const SizedBox(
            child: Offers(),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.green),
            height: 215,
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GestureDetector(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // crossAxisSpacing: 100.0,
                        // mainAxisSpacing: 10,
                      ),
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        List products = snapshots.data!.docs;
                        var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;
                        DocumentSnapshot document = products[index];
                        String productId = document.id;
                        // var isFav = isFavorite[productId] ?? false;
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              IconButton(
                                icon: isProductInFavorites(document.id) == true
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_border),
                                onPressed: () {
                                  // هنا يجب استدعاء الدالة للتحقق مما إذا كان المنتج مفضلًا أم لا
                                  // bool isFav = isProductInFavorites(productId);
                                  // يمكنك هنا تنفيذ العمليات اللازمة بناءً على حالة المفضلة
                                  // مثلاً، إضافة المنتج للمفضلة أو إزالته منها
                                  // على سبيل المثال:
                                  // if (isFav) {
                                  //   // إذا كان المنتج موجودًا بالفعل في المفضلة، فيمكنك إزالته منها هنا
                                  //   // removeFromFavorites(productId);
                                  // } else {
                                  // إذا كان المنتج غير موجود في المفضلة، فيمكنك إضافته إليها هنا
                                  // addToFavorites(productId);
                                  // }
                                },
                              ),
                              const Stack(
                                children: [
                                  // getImageFromFireBase(data),
                                  // IconButton(
                                  //   icon: Icon(
                                  //     isProductInFavorites(productId,data)
                                  //         ? Icons.favorite
                                  //         : Icons.favorite_border,
                                  //     color:  isProductInFavorites == true ? Colors.red : Colors.black,
                                  //   ),
                                  //   onPressed: () {
                                  //     // addProductToFavourites(productId);

                                  //     // setState(() {

                                  //     //   // تغيير حالة المفضلة عند الضغط على الزر
                                  //     //   isFavorite[productId] = !isFav;
                                  //     //   // إضافة أو إزالة المنتج من المفضلة عند الضغط على الزر
                                  //     // });
                                  //   },
                                  // ),
                                ],
                              ),
                              fieldName(data),
                              fieldPrice(data),
                            ],
                          ),
                        );
                      },
                    ),
                    onDoubleTap: () {
                      print("done");
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> isProductInFavorites(String productId) async {
    try {
      // جلب وثيقة المستخدم
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(userEmail).get();

      // جلب المفضلة من بيانات المستخدم والتأكد من أنها قائمة من الأشياء المفضلة
      final RxList<String> favorites = userDoc.get('favorite_products');

      // التحقق مما إذا كان productId موجودًا في قائمة المفضلة أم لا
      return favorites.contains(productId);
    } catch (error) {
      // في حالة حدوث أي خطأ، يمكنك معالجته هنا، مثلاً يمكنك طباعة الخطأ للتحقق منه
      print('Error in isProductInFavorites: $error');
      return false; // يُمثل الخطأ، يمكنك التعامل معه حسب الحاجة
    }
  }

  void addToFavorites(String productId, bool isFav) async {
    //  bool isProductFavorite = isProductInFavorites(productId, favoritesList);

    // try {
    //   if () {
    //     FirebaseFirestore.instance.collection('users').doc(userEmail).update({
    //       'favorite_products': FieldValue.arrayRemove([productId])
    //     });
    //   } else {
    //     await FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(userEmail)
    //         .update({
    //       'favorite_products': FieldValue.arrayRemove([productId])
    //     });
    //   }
    // } catch (error) {
    //   if (kDebugMode) {
    //     print('Error adding to favorites: $error');
    //   }
    // }
  }

  void getFavorites() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userEmail)
              .get();
      if (userSnapshot.exists) {
        List<dynamic> favoritesList = (userSnapshot.data()
                as Map<String, dynamic>)['favorite_products'] ??
            [];
        Map<String, bool> favMap = {};
        for (var productId in favoritesList) {
          favMap[productId] = true;
        }
        setState(() {
          // isFavorite = favMap;
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error getting favorites: $error');
      }
    }
  }

  void addProductToFavourites(String productId) async {
    try {
      // addToFavorites(productId, isFavorite[productId] ?? false);
    } catch (error) {
      if (kDebugMode) {
        print('Error adding to favorites: $error');
      }
    }
  }

  // باقي جزء الكود كما هو
}

Widget getImageFromFireBase(Map<String, dynamic> data) {
  return FutureBuilder(
    future: FirebaseStorage.instance
        .ref()
        .child(data['product_image'])
        .getDownloadURL(),
    builder: (context, AsyncSnapshot<String> urlSnapshot) {
      if (urlSnapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }

      if (urlSnapshot.hasError) {
        return const Icon(Icons.error_outline);
      }

      return Container(
        width: 120, // يمكنك تعيين عرض وارتفاع الحاوية حسب رغبتك
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(urlSnapshot.data!),
          ),
        ),
      );
    },
  );
}

Text fieldName(Map<String, dynamic> data) {
  return Text(
    data['product_name'] ?? "",
    style: const TextStyle(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text fieldSize(Map<String, dynamic> data) {
  return Text(
    data['size'] ?? "",
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
