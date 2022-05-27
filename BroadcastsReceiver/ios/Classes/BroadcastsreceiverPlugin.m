#import "BroadcastsreceiverPlugin.h"
#if __has_include(<broadcastsreceiver/broadcastsreceiver-Swift.h>)
#import <broadcastsreceiver/broadcastsreceiver-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "broadcastsreceiver-Swift.h"
#endif

@implementation BroadcastsreceiverPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBroadcastsreceiverPlugin registerWithRegistrar:registrar];
}
@end
