//
//  MockMyFaceAppDelegate.m
//  MockMyFace
//
//  Created by Jaume Cornadó on 10/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import "MockMyFaceAppDelegate.h"

#import "MockCameraViewConroller.h"

@implementation MockMyFaceAppDelegate


@synthesize window = _window;
@synthesize viewController = _viewController;

@synthesize facebook;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[MockCameraViewController alloc] initWithNibName:@"MockCameraViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

// Add for Facebook SSO support (4.2+)
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook handleOpenURL:url];
}

-(void) postImageToFacebook:(UIImage *)image {
    self.facebook = [[Facebook alloc] initWithAppId:@"123366887777694" andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"FBAccessTokenKey"]
       && [defaults objectForKey:@"FBExpirationDateKey"]) {
        self.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        self.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if(![facebook isSessionValid]) {
        // Permissions
        NSArray *permissions =  [NSArray arrayWithObjects:@"publish_stream",@"read_stream",@"offline_access",nil];     

        [self.facebook authorize:permissions];
    }
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Image by MockMyFace iOS App", @"message", imageData, @"source", nil];
    
    [self.facebook requestWithGraphPath:@"me/photos"
                                    andParams:params
                                andHttpMethod:@"POST"
                                  andDelegate:self];
}





@end
