import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/controllers/menu_watcher/menu_watcher_bloc.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_app_bar_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewPage extends StatelessWidget {
  const QRViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double hintBoxWidth = 200.0;

    return Scaffold(
      appBar: pageLayoutAppBar(
        context,
        appBarTitle: AppLocalizations.of(context)!.appTitle,
      ),
      body: Stack(
        children: <Widget>[
          const Expanded(
            child: QRScanAreaWidget(),
          ),
          // 懸浮窗格
          Positioned(
            bottom: 40.0, // 距離底部的距離
            left: (MediaQuery.of(context).size.width - hintBoxWidth) / 2,
            child: Container(
              width: hintBoxWidth,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.black.withOpacity(0.8),
              ),
              height: 30.0,
              child: Center(
                child: FittedBox(
                  child: Text(
                    AppLocalizations.of(context)!.scanQrCodeTitle,
                    style: AppTextStyle.text(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QRScanAreaWidget extends StatefulWidget {
  const QRScanAreaWidget({super.key});

  @override
  State<QRScanAreaWidget> createState() => _QRScanAreaWidgetState();
}

class _QRScanAreaWidgetState extends State<QRScanAreaWidget>
    with TickerProviderStateMixin {
  late QRViewController qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // // 為了加閃爍動畫
  // late AnimationController controller;
  // // late Animation colorAnimation;
  // late Animation<double> colorAnimation;

  // late bool isAreaWithBorder = true;

  // // @override
  // // void initState() {
  // //   super.initState();
  // //   controller = AnimationController(
  // //     vsync: this,
  // //     duration: const Duration(milliseconds: 500),
  // //   );
  // //   colorAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(controller);

  // //   controller.addStatusListener((status) {
  // //     if (status == AnimationStatus.completed) {
  // //       controller.reverse();
  // //     } else if (status == AnimationStatus.dismissed) {
  // //       controller.forward();
  // //     }
  // //   });
  // //   controller.forward();
  // // }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController.pauseCamera();
    }
    qrController.resumeCamera();
  }

  Widget _buildQrView(BuildContext context, Color? color) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = MediaQuery.of(context).size.width / 2;

    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    // return AnimatedBuilder(
    // animation: colorAnimation,
    // builder: (context, child) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white, // .withOpacity(colorAnimation.value)
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
    // }
    // );
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      this.qrController = qrController;
    });
    qrController.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        context.read<MenuWatcherBloc>().add(
              ScanQRCodeEvent(storeSeatId: scanData.code!),
            );
        qrController.pauseCamera();
        context.pop();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildQrView(
      context,
      null,
    );
  }

  @override
  void dispose() {
    // controller.dispose();
    qrController.dispose();
    super.dispose();
  }
}
