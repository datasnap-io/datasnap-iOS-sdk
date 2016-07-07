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

    VendorProperties* vendorProperties = [[VendorProperties alloc] initWithVendor:GIMBAL andgimbalApiKey:@"Enter your Gimbal API key"];
    Datasnap* datasnap = [Datasnap sharedClient];
    //IDFAOptIn is a property that, when true, allows Datasnap to collect the IDFA for the device. If YES is passed for this parameter, ads must be served through the application. If not, the App Store will not accept the app.
    //Provided email will be hashed before being sent to Datasnap server.
    datasnap = [datasnap initWithApiKey:@"Enter your Datasnap API key"
                           apiKeySecret:@"Enter your Datasnap API secret"
                         organizationId:@"Enter your organization ID"
                              projectId:@"Enter your project ID"
                              IDFAOptIn:YES
                                  email:@"someone@example.com"
                    andVendorProperties:vendorProperties];
    //max elements property denotes the batch size, duration property denotes the amount of milliseconds the sdk will wait before making an api call
    [datasnap setFlushParamsWithDuration:10000 withMaxElements:10];
    return YES;
}
- (void)application:(UIApplication*)app
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    [Gimbal setPushDeviceToken:deviceToken];
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
