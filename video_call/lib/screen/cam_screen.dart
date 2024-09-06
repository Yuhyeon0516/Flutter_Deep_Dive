import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/const/keys.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;
  int uid = 0;
  int? remoteUid;

  Future<void> init() async {
    final res = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = res[Permission.camera];
    final microphonePermission = res[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        microphonePermission != PermissionStatus.granted) {
      throw "카메라 또는 마이크 권한이 없습니다.";
    }

    if (engine == null) {
      engine = createAgoraRtcEngine();

      await engine!.initialize(RtcEngineContext(appId: appId));

      engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (connection, elapsed) {},
          onLeaveChannel: (connection, stats) {},
          onUserJoined: (connection, remoteUid, elapsed) {
            print('------ User Join ------');
            setState(() {
              this.remoteUid = remoteUid;
            });
          },
          onUserOffline: (connection, remoteUid, reason) {
            this.remoteUid = null;
          },
        ),
      );

      await engine!.enableVideo();
      await engine!.startPreview();

      ChannelMediaOptions options = ChannelMediaOptions();

      await engine!.joinChannel(
          token: token, channelId: channelName, uid: uid, options: options);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIVE"),
      ),
      body: FutureBuilder<void>(
          future: init(),
          builder: (context, snapshot) {
            // FutureBuilder에 삽입된 함수에서 에러가 발생했을때
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            // FutureBuilder의 함수의 처리가 아직 완료되지 않았을때
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
              children: [
                Container(
                  child: renderMainView(),
                ),
                Container(
                  width: 120,
                  height: 160,
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine!,
                      canvas: VideoCanvas(
                        uid: uid,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      engine!.leaveChannel();
                      engine!.release();

                      Navigator.of(context).pop();
                    },
                    child: Text("나가기"),
                  ),
                ),
              ],
            );
          }),
    );
  }

  renderMainView() {
    if (remoteUid == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine!,
        canvas: VideoCanvas(uid: remoteUid),
        connection: RtcConnection(
          channelId: channelName,
        ),
      ),
    );
  }
}
