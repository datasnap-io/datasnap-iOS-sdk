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

    VendorProperties* vendorProperties = [[VendorProperties alloc] initWithVendor:GIMBAL andgimbalApiKey:@"Enter Gimbal API key"];
    Datasnap* datasnap = [Datasnap sharedClient];
    //IDFA is the advertising identifier for the device. Pass in nil for this property if advertising is not used in the app.
    //Provided email will be hashed before being sent to Datasnap server.
    datasnap = [datasnap initWithApiKey:@"Enter Datasnap API Key"
                           apiKeySecret:@"Enter Datasnap API Secret"
                         organizationId:@"Enter your organization ID"
                              projectId:@"Enter your project ID"
                                   IDFA:@"example idfa"
                                  email:@"someone@example.com"
                    andVendorProperties:vendorProperties];
    //max elements property denotes the batch size, duration property denotes the amount of milliseconds the sdk will wait before making an api call
    [datasnap setFlushParamsWithDuration:100000 withMaxElements:10];
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
