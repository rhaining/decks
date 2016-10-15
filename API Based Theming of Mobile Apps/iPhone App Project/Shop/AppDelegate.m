//
//  AppDelegate.m
//  Shop
//
//  Created by Robert Haining on 10/26/15.
//  Copyright © 2015 Braintree, a division of PayPal, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <PayPalCommerce/PayPalCommerce.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //general app setup stuff
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    // the good stuff! let's configure paypal commerce!
    // we're defaulting to a sample store,
    // but you should replace these with your own credentials from commerce.paypal.com
#warning Please obfuscate the client id & secret before shipping. Thanks! paypal commerce
    NSString *clientId = @"taer2j0DTrerY5h1NpxHKw";
    NSString *clientSecret = @"wD76U3uUQJOkQ5JKrujADAkQus9sC0RH6Lqrpq9lgkag";
    
    if(!clientId || !clientSecret){
        [NSException raise:@"PayPalCommerceException" format:@"Missing client id + secret"];
        return YES;
    }
    
    [PayPalCommerce configureWithClientID:clientId clientSecret:clientSecret launchOptions:launchOptions];
    [PayPalCommerce presentStoreApp];

    return YES;

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [PayPalCommerce openURL:url sourceApplication:sourceApplication annotation:annotation];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray *restorableObjects))restorationHandler {
    [PayPalCommerce continueUserActivity:userActivity restorationHandler:restorationHandler];
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [PayPalCommerce didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [PayPalCommerce didFailToRegisterForRemoteNotificationsWithError:error];
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [PayPalCommerce didRegisterUserNotificationSettings:notificationSettings];
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [PayPalCommerce didReceiveRemoteNotification:userInfo];
}

// In order for Home Screen 3D Touch actions to work properly in iOS 9+ on supported devices:
-(void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler{
    BOOL didPerformAction = [PayPalCommerce performActionForShortcutItem:shortcutItem];
    if(!didPerformAction){
        //if you added any custom 3D Touch shortcuts, you can handle them here
    }
    completionHandler(didPerformAction);
}

@end
