//
//  DSIOAppDelegate.m
//  Datasnap
//
//  Created by Layne McIntyre on 06/24/2016.
//  Copyright (c) 2016 Layne McIntyre. All rights reserved.
//
#import "DSIOAppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings* mySettings =
        [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    //VendorProperties* vendorProperties = [[VendorProperties alloc] initWithVendor:GIMBAL andgimbalApiKey:@"74e344e9-9625-4b9d-96cf-e7805479d33c"];
    Datasnap* datasnap = [Datasnap sharedClient];
    //IDFAOptIn is a property that, when true, allows Datasnap to collect the IDFA for the device. If YES is passed for this parameter, ads must be served through the application. If not, the App Store will not accept the app.
    //Provided email will be hashed before being sent to Datasnap server.
    datasnap = [datasnap initWithApiKey:@"3F34FXD78PCINFR99IYW950W4"
                           apiKeySecret:@"KA0HdzrZzNjvUq8OnKQoxaReyUayZY0ckNYoMZURxK8"
                         organizationId:@"19CYxNMSQvfnnMf1QS4b3Z"
                              projectId:@"21213f8b-8341-4ef3-a6b8-ed0f84945186"
                              IDFAOptIn:YES
                                  email:@"someemail@example.com"
                    andVendorProperties:nil];
    //max elements property denotes the batch size, duration property denotes the amount of milliseconds the sdk will wait before making an api call
    [datasnap setFlushParamsWithDuration:10000 withMaxElements:10];
    return YES;
}
- (void)application:(UIApplication*)app
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
   // [Gimbal setPushDeviceToken:deviceToken];
}

- (void)application:(UIApplication*)app
    didFailToRegisterForRemoteNotificationsWithError:(NSError*)err
{
    NSLog(@"Error in registration. Error: %@", err);
}
- (void)applicationWillResignActive:(UIApplication*)application
{
}

- (void)applicationDidEnterBackground:(UIApplication*)application
{
}

- (void)applicationWillEnterForeground:(UIApplication*)application
{
}

- (void)applicationDidBecomeActive:(UIApplication*)application
{
}

- (void)applicationWillTerminate:(UIApplication*)application
{
}

@end
