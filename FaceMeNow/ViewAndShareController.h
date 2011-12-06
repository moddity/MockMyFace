//
//  ViewAndShareController.h
//  MockMe
//
//  Created by Jaume Cornadó on 22/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <ImageIO/ImageIO.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ShareController.h"
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#import "FBConnect.h"
#import "FBRequest.h"


@interface ViewAndShareController : UIViewController <ShareControllerDelegate, MFMailComposeViewControllerDelegate,FBSessionDelegate, FBRequestDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *previewImage;
@property (strong, nonatomic) NSDictionary *imageMetatadata;
@property (strong, nonatomic) ShareController *shareController;



-(IBAction) close: (id) sender;
-(IBAction) openShareView:(id)sender;
-(IBAction) saveToCameraRoll:(id)sender;

- (BOOL)writeCGImageToCameraRoll:(CGImageRef)cgImage withMetadata:(NSDictionary *)metadata;

-(void) sendImageToFacebook;

@end
