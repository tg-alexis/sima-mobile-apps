import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/common.dart';
import '../../../styles/colors/colors.dart';
import '../../../utils/utils.dart';
import '../event.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final MobileScannerController _scanController = MobileScannerController();
  late EventController _eventController;
  bool _isScan = false;

  @override
  void initState() {
    _eventController = ref.read(eventControllerProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _requestCameraPermission();
    });
    super.initState();
  }

  @override
  void dispose() {
    stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: SizerHelper.w(70),
      height: SizerHelper.w(70),
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            controller: _scanController,
            scanWindow: scanWindow,
            onDetect: (barcode) {
              debugPrint("result ${barcode.barcodes[0].rawValue}");
              var result = barcode.barcodes[0].rawValue!;
              if (result.isNotEmpty && !_isScan) {
                checkAccess(attendeeId: result);
              }
            },
          ),
          Positioned(
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: QrScannerOverlayShape(
                  borderColor: AppColors.primaryColor,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 5,
                  cutOutWidth: SizerHelper.w(70),
                  cutOutHeight: SizerHelper.w(70),
                ),
              ),
            ),
          ),
          // Bouton de retour en bas
          Positioned(
            bottom: SizerHelper.w(10),
            left: SizerHelper.w(10),
            right: SizerHelper.w(10),
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(SizerHelper.w(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      NavigationUtil.pop(context);
                    },
                    borderRadius: BorderRadius.circular(SizerHelper.w(4)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SizerHelper.w(4),
                        horizontal: SizerHelper.w(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: AppColors.primaryColor,
                            size: SizerHelper.w(6),
                          ),
                          SizedBox(width: SizerHelper.w(3)),
                          MediumText(
                            "Retour à l'accueil",
                            color: AppColors.primaryColor,
                            fontSize: SizerHelper.sp(16),
                          ),
                        ],
                      ),
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

  void checkAccess({required String attendeeId}) async {
    setState(() => _isScan = true);

    Dialogs.showLoadingDialog(context, message: "Vérification en cours...");
    var result = await _eventController.checkAccess(attendeeId: attendeeId);

    if (!mounted) return;

    Navigator.pop(context);
    if (!result) {
      Dialogs.displayInfoDialog(
        context,
        text: _eventController.errorMessage ?? "Erreur lors de la vérification",
        callback: () {
          setState(() => _isScan = true);
        },
        isError: true,
      );
      return;
    }

    Dialogs.displayInfoDialog(
      context,
      text: "Accès autorisé",
      callback: () {
        Navigator.pop(context);
      },
    );
  }

  void _requestCameraPermission() async {
    // Vérifier le statut de la permission (déjà demandée au démarrage)
    var result = await statusPermission(Permission.camera);
    if (!mounted) return;

    if (!result) {
      // Si la permission n'est toujours pas accordée, proposer d'ouvrir les paramètres
      Dialogs.displayInfoDialog(
        context,
        text:
            "L'accès à la caméra est nécessaire pour scanner les QR codes. Veuillez l'activer dans les paramètres.",
        callback: () async {
          await openAppSettings();
          if (!mounted) return;
          NavigationUtil.pop(context);
        },
        isError: true,
      );
      return;
    }
  }

  void stopCamera() async {
    await _scanController.stop();
    await _scanController.dispose();
  }
}

class QrScannerOverlayShape extends ShapeBorder {
  QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    this.overlayColor = const Color.fromARGB(200, 0, 0, 0),
    this.borderRadius = 0,
    this.borderLength = 40,
    double? cutOutSize,
    double? cutOutWidth,
    double? cutOutHeight,
    this.cutOutBottomOffset = 0,
  }) : cutOutWidth = cutOutWidth ?? cutOutSize ?? 250,
       cutOutHeight = cutOutHeight ?? cutOutSize ?? 250 {
    assert(
      borderLength <=
          min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2,
      "Border can't be larger than ${min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2}",
    );
    assert(
      (cutOutWidth == null && cutOutHeight == null) ||
          (cutOutSize == null && cutOutWidth != null && cutOutHeight != null),
      'Use only cutOutWidth and cutOutHeight or only cutOutSize',
    );
  }

  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutWidth;
  final double cutOutHeight;
  final double cutOutBottomOffset;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return getLeftTopPath(rect)
      ..lineTo(rect.right, rect.bottom)
      ..lineTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.top);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final borderWidthSize = width / 2;
    final height = rect.height;
    final borderOffset = borderWidth / 2;
    final mBorderLength =
        borderLength > min(cutOutHeight, cutOutHeight) / 2 + borderWidth * 2
        ? borderWidthSize / 2
        : borderLength;
    final mCutOutWidth = cutOutWidth < width
        ? cutOutWidth
        : width - borderOffset;
    final mCutOutHeight = cutOutHeight < height
        ? cutOutHeight
        : height - borderOffset;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - mCutOutWidth / 2 + borderOffset,
      -cutOutBottomOffset +
          rect.top +
          height / 2 -
          mCutOutHeight / 2 +
          borderOffset,
      mCutOutWidth - borderOffset * 2,
      mCutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(rect, backgroundPaint)
      ..drawRect(rect, backgroundPaint)
      // Draw top right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.top,
          cutOutRect.right,
          cutOutRect.top + mBorderLength,
          topRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw top left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.top,
          cutOutRect.left + mBorderLength,
          cutOutRect.top + mBorderLength,
          topLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.right,
          cutOutRect.bottom,
          bottomRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.left + mBorderLength,
          cutOutRect.bottom,
          bottomLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius)),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
