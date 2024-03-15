// ignore_for_file: unused_import
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'add_product.dart';
import 'firebase_options.dart';
import 'authentication/login_page.dart';
import 'package:ecommerce/image_from_firebase/lib/Screens/home_page.dart';
import 'flutter-e-commercee/ui/splash_screen.dart';
import 'navigate_bar_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // String? token = await FirebaseMessaging.instance.getToken();a

  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: const [
            // GetPage(name: '/choosingPage', page: () => choosingPage()),
            // GetPage(name: '/loginPage', page: () => const LoginPage()),
            // GetPage(name: "/chatHomePage", page: () => const HomePage()),
            // GetPage(
            //     name: "/choiceTypeRooms", page: () => const ChoiceTypeRooms()),
            // GetPage(name: "/home", page: () => BtmNavVeiw()),
            // GetPage(name: "/store", page: () => Store()),
            // // //    Drawer     /////////////////////
            // GetPage(name: "/profile", page: () => const Profile()),
            // GetPage(
            //     name: '/customerService', page: () => const CustomerService()),
            // GetPage(name: '/roomMangement', page: () => const RoomMangement()),
            // GetPage(
            //     name: '/roomSettingsPage',
            //     page: () => const RoomSettingsPage()),
            // GetPage(
            //     name: '/customerServiceChat',
            //     page: () => const CustomerServiceChat()),
            // GetPage(name: '/salesChat', page: () => const SalesChat()),
            // GetPage(
            //     name: '/complaintsSuggestions',
            //     page: () => const ComplaintsSuggestions()),
            // GetPage(name: '/about', page: () => const About()),
            // GetPage(name: '/moments', page: () => const Moments()),
            // GetPage(name: '/roomInfo', page: () => RoomInfo()),
            // GetPage(name: '/privateMessage', page: () => PrivateMessage()),
            // GetPage(name: '/addAccount', page: () => const AddAccount()),
            // GetPage(name: '/roles', page: () => const RolesPage()),
            // GetPage(name: "/search", page: () => Search()),
            // GetPage(name: "/roomSetting", page: () => RoomSettings()),
            // GetPage(name: "/favourite", page: () => const Favourite()),
            // GetPage(name: "/trophy", page: () => const Trophy()),
            // GetPage(
            //     name: "/changeBackground",
            //     page: () => const ChangeBackground()),
            // GetPage(
            //     name: "/editBackground", page: () => const EditBackground()),
            // GetPage(name: "/editPerson", page: () => const EditPerson()),
            // GetPage(
            //     name: "/editProfile", page: () => const EditProfileAccount()),
            // GetPage(
            //     name: "/mainControllerPanel", page: () => const ControlPanel()),
            // GetPage(
            //     name: "/changePasswordRoom",
            //     page: () => const ChangePasswordRoom()),
            // GetPage(
            //     name: "/privateMessageRoom",
            //     page: () => const PrivateMessageRoom()),
            // GetPage(name: "/addRoot", page: () => AddRoot()),
            // GetPage(name: "/postMoment", page: () => const PostMoment()),
            // GetPage(name: "/viewImage", page: () => const ViewImage()),
            // GetPage(name: '/previousChat', page: () => const PreviosChat()),
            // GetPage(
            //     name: "/advancedSettings",
            //     page: () => const AdvancedSettings()),
            // GetPage(
            //     name: "/cameraSettings", page: () => const CameraSettings()),
            // GetPage(name: "/callSettings", page: () => const CallSettings()),
            // GetPage(name: "/blockPage", page: () => const Blocked()),
            // GetPage(name: "/viewComments", page: () => const ViewComments()),
            // GetPage(
            //     name: "/editPersonalProfile",
            //     page: () => const EditPersonalProfile()),
            // GetPage(
            //     name: "/privateMessagesSettings",
            //     page: () => const PrivateMessages()),
            // GetPage(name: "/storeDetails", page: () => const StoreDetails()),
            // GetPage(name: "/editRole", page: () => const EditRole()),
          ],
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AddProductPage();
              } else {
                return AddProductPage();
              }
            },
          ),
        );
      },
      // child: const MyAppWhisper(),
      // child: TestTwo(),
      // child: PrivateMessageRoom(),
      // child: const Moments(),
    );
  }
}
// //////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'test_two.dart';

// void main() async {
//   runApp(const MapScreen());
// }

// class MyAppMap extends StatefulWidget {
//   const MyAppMap({super.key});

//   @override
//   _MyAppMapState createState() => _MyAppMapState();
// }

// class _MyAppMapState extends State<MyAppMap> {
//   CameraPosition cameraPosition = const CameraPosition(
//       target: LatLng(30.044441652921257, 31.23564484287617));
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('live location tracker'),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(child: GoogleMap(initialCameraPosition: cameraPosition)),
//           ],
//         ),
//       ),
//     );
//   }
// }

