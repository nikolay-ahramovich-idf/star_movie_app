import Cocoa
import FlutterMacOS

public class ShareMoviePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "share_movie_plugin", binaryMessenger: registrar.messenger)
        let instance = ShareMoviePlugin()
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
        let picker = NSSharingServicePicker(items: [message])
        
        DispatchQueue.main.async {
            if let contentView = NSApplication.shared.keyWindow?.contentView {
                picker.show(relativeTo: .zero, of: contentView, preferredEdge: .minY)
            }
        }
    }
}
