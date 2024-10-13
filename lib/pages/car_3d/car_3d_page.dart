import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Car3dPage extends StatefulWidget {
  const Car3dPage({super.key});

  @override
  State<Car3dPage> createState() => _Car3dPageState();
}

class _Car3dPageState extends State<Car3dPage> {
  Flutter3DController controller = Flutter3DController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(title: const Text('3D Car')),
      body: SafeArea(
        child:
            // Column(
            //   children: [
            //     Container(
            //       decoration: const BoxDecoration(
            //         color: Colors.black12,
            //       ),
            //       width: double.infinity,
            //       height: 335.h,
            //       child: _carOne(),
            //     ),
            //     SizedBox(
            //       width: double.infinity,
            //       height: 340.h,
            //       child: _carTwo(),
            //     )
            //   ],
            // ),
            _carOne(),
        // _carTwo(),
      ),
    );
  }

  Widget _carOne() {
    return Flutter3DViewer(
      activeGestureInterceptor: true,
      progressBarColor: Colors.orange,
      enableTouch: true,
      onProgress: (double progressValue) {
        debugPrint('model loading progress : $progressValue');
      },
      onLoad: (String modelAddress) {
        debugPrint('model loaded : $modelAddress');
      },
      onError: (String error) {
        debugPrint('model failed to load : $error');
      },
      controller: controller,
      src: 'assets/models/bmw.glb',
      //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
    );
  }

  Widget _carTwo() {
    return const ModelViewer(
      backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
      // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',÷
      src: 'assets/models/benz.glb',
      alt: '3D car',
      ar: true,
      autoRotate: false,
      // iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
      disableZoom: true,
    );
  }
}
