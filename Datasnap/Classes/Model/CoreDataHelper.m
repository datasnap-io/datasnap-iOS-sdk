//
//  CoreDataHelper.m
//  Datasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 5/31/16.
//  Copyright © 2016 Datasnap. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper
#define debug 1
@synthesize context = _context;
@synthesize model = _model;
@synthesize coordinator = _coordinator;

#pragma mark - FILES
NSString* storeFilename = @"dataSnapSample.sqlite";

#pragma mark - PATHS
- (NSString*)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(
        NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
- (NSURL*)applicationStoresDirectory
{
    NSURL* storesDirectory =
        [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]]
            URLByAppendingPathComponent:@"Stores"];

    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError* error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&error]) {
        }
        else {
            NSLog(@"FAILED to create Stores directory: %@", error);
        }
    }
    return storesDirectory;
}
- (NSURL*)storeURL
{
    return [[self applicationStoresDirectory]
        URLByAppendingPathComponent:storeFilename];
}

#pragma mark - SETUP
- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }

    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    _context = [[NSManagedObjectContext alloc]
        initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:_coordinator];
    [self loadStore];
    return self;
}
+ (id)sharedManager
{
    static CoreDataHelper* sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}
- (void)loadStore
{
    if (_store) {
        return;
    } // Don't load store if it's already loaded
    NSError* error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                        configuration:nil
                                                  URL:[self storeURL]
                                              options:nil
                                                error:&error];
    if (!_store) {
        NSLog(@"Failed to add store. Error: %@", error);
        abort();
    }
}

#pragma mark - SAVING
- (void)saveInMainContext
{
    [self saveInContext:_context];
}
- (void)saveInContext:(NSManagedObjectContext*)localContext
{
    if (![NSThread isMainThread]) {
        NSLog(@"You are not in main thread");
    }

    if ([localContext hasChanges]) {
        NSError* error = nil;
        if ([localContext save:&error]) {
        }
        else {
            NSLog(@"Failed to save _context: %@", error);
        }
    }
}

@end
