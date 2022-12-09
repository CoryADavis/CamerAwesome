import 'package:camerawesome/src/layouts/awesome/widgets/awesome_capture_button.dart';
import 'package:camerawesome/src/orchestrator/models/media_capture.dart';
import 'package:flutter/material.dart';

import '../../../camerawesome_plugin.dart';
import 'widgets/awesome_aspect_ratio_button.dart';
import 'widgets/awesome_camera_mode_selector.dart';
import 'widgets/awesome_camera_switch_button.dart';
import 'widgets/awesome_flash_button.dart';
import 'widgets/awesome_location_button.dart';
import 'widgets/awesome_media_preview.dart';

/// This widget doesnt handle [PreparingCameraState]
class AwesomeCameraLayout extends StatelessWidget {
  final CameraState state;
  final OnMediaTap onMediaTap;

  const AwesomeCameraLayout({
    super.key,
    required this.state,
    this.onMediaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        AwesomeTopActions(state: state),
        Spacer(),
        const SizedBox(height: 12),
        AwesomeBackground(
          child: Column(children: [
            AwesomeCameraModeSelector(state: state),
            AwesomeBottomActions(state: state, onMediaTap: onMediaTap),
            const SizedBox(height: 32),
          ]),
        ),
      ],
    );
  }
}

class AwesomeTopActions extends StatelessWidget {
  final CameraState state;

  const AwesomeTopActions({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AwesomeFlashButton(state: state),
        AwesomeAspectRatioButton(state: state),
        AwesomeLocationButton(state: state),
      ],
    );
  }
}

class AwesomeBottomActions extends StatelessWidget {
  final CameraState state;
  final OnMediaTap onMediaTap;

  const AwesomeBottomActions({
    super.key,
    required this.state,
    this.onMediaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 0,
            child: AwesomeCameraSwitchButton(state: state),
          ),
          // Spacer(),
          AwesomeCaptureButton(
            state: state,
          ),
          // Spacer(),
          Flexible(
            flex: 0,
            child: StreamBuilder<MediaCapture?>(
              stream: state.captureState$,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(width: 72, height: 72);
                }
                return SizedBox(
                  width: 72,
                  child: AwesomeMediaPreview(
                    mediaCapture: snapshot.requireData,
                    onMediaTap: onMediaTap,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AwesomeBackground extends StatelessWidget {
  final Widget child;

  const AwesomeBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: child,
    );
  }
}
