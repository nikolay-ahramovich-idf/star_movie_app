import Flutter
import UIKit

public class SwiftShareMoviePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "share_movie_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftShareMoviePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "shareMovie" {
      let arguments = call.arguments as! [String: Any]
      let message = arguments["message"] as! String
      shareMovie(message)
      result(nil)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func shareMovie(_ message: String) {
    let controller = UIActivityViewController(activityItems:[message], applicationActivities: nil)
    let viewController = UIApplication.shared.keyWindow!.rootViewController
    viewController?.present(controller,animated: true)
  }
}
