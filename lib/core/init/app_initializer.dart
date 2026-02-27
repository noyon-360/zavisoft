import 'package:flutter/widgets.dart';
import 'package:flutx_core/flutx_core.dart';

import 'package:get/get.dart';
import '../services/hive_storage_service.dart';
import '../di/service_locator.dart';
import '../services/request_queue_service.dart';

class AppInitializer {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Limit total image cache
    PaintingBinding.instance.imageCache.maximumSize = 100; // 100 images
    PaintingBinding.instance.imageCache.maximumSizeBytes = 100 << 20; // 100 MB

    // Lock to portrait orientation at app start
    // import 'package:flutter/services.dart';
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await HiveStorageService.init();
    try {
      await setupServiceLocator();
      await Get.find<RequestQueueService>().initialize();
      DPrint.log("Service Locator & Request Queue Setup Completed");
    } catch (err) {
      DPrint.log("Error in Service Locator Setup: $err");
    }

    // SocketClient().connect();
    // Wait for connection
    // SocketClient().onReady;
  }
}
