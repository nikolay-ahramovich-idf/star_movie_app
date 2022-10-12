#import "ShareMoviePlugin.h"
#if __has_include(<share_movie_plugin/share_movie_plugin-Swift.h>)
#import <share_movie_plugin/share_movie_plugin-Swift.h>
#else
#import "share_movie_plugin-Swift.h"
#endif

@implementation ShareMoviePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftShareMoviePlugin registerWithRegistrar:registrar];
}
@end
