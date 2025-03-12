



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';


final permissionProvider = StateNotifierProvider<PermissionNotifier, PermissionState>((ref) {
  return PermissionNotifier();
});

class PermissionNotifier extends StateNotifier<PermissionState>{
  PermissionNotifier(): super(PermissionState());

  
  Future<void> checkPermissions() async {
    final permissionArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status
    ]);

    state = state.copyWith(
      camera: permissionArray[0],
      photoLibrary: permissionArray[1],
      sensor: permissionArray[2],
      location: permissionArray[3],
      locationAlways: permissionArray[4],
      locationWhenInUse: permissionArray[5],
    );
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    if(status == PermissionStatus.permanentlyDenied){
      openAppSettings();
    }
  }

  requestPhotoLibraryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);

    if(status == PermissionStatus.permanentlyDenied){
      openAppSettings();
    }
  }

  requestSensorAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensor: status);

    if(status == PermissionStatus.permanentlyDenied){
      openAppSettings(); }
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    if(status == PermissionStatus.permanentlyDenied){
      openAppSettings();
    }
  } 

  requestLocationAlwaysAccess() async {
    final status = await Permission.locationAlways.request();
    state = state.copyWith(locationAlways: status);

    if(status == PermissionStatus.permanentlyDenied){
      openAppSettings();
    }
  }

  requestLocationWhenInUseAccess() async {
    final status = await Permission.locationWhenInUse.request();
    state = state.copyWith(locationWhenInUse: status);

    if(status == PermissionStatus.permanentlyDenied){
      openAppSettings();
    }
  }


  
}


class PermissionState{
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensor;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionState({
     this.camera = PermissionStatus.denied,
     this.photoLibrary = PermissionStatus.denied,
     this.sensor = PermissionStatus.denied,
     this.location = PermissionStatus.denied,
     this.locationAlways = PermissionStatus.denied,
     this.locationWhenInUse = PermissionStatus.denied
  });

  get cameraGranted{
    return camera == PermissionStatus.granted;
  }

  get photoLibraryGranted{
    return photoLibrary == PermissionStatus.granted;
  }

  get sensorGranted{
    return sensor == PermissionStatus.granted;
  }

  get locationGranted{
    return location == PermissionStatus.granted;
  }

  get locationAlwaysGranted{
    return locationAlways == PermissionStatus.granted;
  }

  get locationWhenInUseGranted{
    return locationWhenInUse == PermissionStatus.granted;
  }


  PermissionState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensor,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) {
    return PermissionState(
      camera: camera ?? this.camera,
      photoLibrary: photoLibrary ?? this.photoLibrary,
      sensor: sensor ?? this.sensor,
      location: location ?? this.location,
      locationAlways: locationAlways ?? this.locationAlways,
      locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
    );
  }
  
}