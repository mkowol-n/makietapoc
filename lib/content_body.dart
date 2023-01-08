import 'package:flutter/material.dart';
import 'package:makieta_poc/my_canvas.dart';

class ContentBody extends StatefulWidget {
  const ContentBody({Key? key}) : super(key: key);

  @override
  State<ContentBody> createState() => _ContentBodyState();
}

class _ContentBodyState extends State<ContentBody> {
  bool isPainter = false;

  List<Offset>? pointList = [];

  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractiveViewer(
          transformationController: _transformationController,
          onInteractionStart: (details) {
            pointList = [];
          },
          onInteractionUpdate: (details) {
            setState(() {
              final scenePoint =
                  _transformationController.toScene(details.localFocalPoint);

              pointList = [...pointList ?? [], scenePoint];
            });
          },
          onInteractionEnd: (details) {
            //pointList = null;
          },
          panEnabled: !isPainter,
          scaleEnabled: !isPainter,
          constrained: false,
          maxScale: 5,
          minScale: 0.1,
          child: Stack(
            children: [
              Image.network(
                  'https://architect-yourhome.com/wp-content/uploads/2021/01/285-PD-Drwgs-section-pdf.jpg'),
              if (isPainter) ...{
                IgnorePointer(
                  ignoring: true,
                  child: MyCanvas(
                    height: 1700.0,
                    width: 1200.0,
                    offset: pointList,
                    scenePoint: Offset(0, 0),
                  ),
                )
              }
            ],
          ),
        ),
        MaterialButton(
          onPressed: onButtonPressed,
          color: Colors.red,
          child: Text(isPainter ? "Painter" : "No painter"),
        ),
      ],
    );
  }

  void onButtonPressed() {
    setState(() {
      isPainter = !isPainter;
    });
  }
}
