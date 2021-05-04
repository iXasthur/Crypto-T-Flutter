import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
       let nsDictionary = NSDictionary(contentsOfFile: path),
       let API_KEY = nsDictionary["API_KEY"] as? String {
        GMSServices.provideAPIKey(API_KEY)
    } else {
        fatalError()
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
