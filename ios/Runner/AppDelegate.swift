import Flutter
import UIKit
import GoogleMaps
GMSServices.provideAPIKey("AIzaSyASN57TPQp7IZrLjF9gQi2Xwg39o7YOnZI")
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
