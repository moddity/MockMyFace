//
//  FaceMeNowViewController.h
//  FaceMeNow
//
//  Created by Jaume Cornadó on 10/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ItemSelector.h"
#import "ViewAndShareController.h"
#import "FaceIndicatorLayer.h"

#define kSunglassesLayer @"SunglassesLayer"
#define kHatLayer @"HatLayer"
#define kMouthLayer @"MouthLayer"
#define kBeardLayer @"BeardLayer"

@class CIDetector;

@interface FaceMeNowViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate, ItemSelectorDelegate> {
	
	dispatch_queue_t videoDataOutputQueue;
	
	BOOL isUsingFrontFacingCamera;
	CIDetector *faceDetector;
	CGFloat beginGestureScale;
	CGFloat effectiveScale;
}

@property (nonatomic, strong) IBOutlet ItemSelector *itemSelectorViewController;
@property (nonatomic, strong) ViewAndShareController *previewController;
@property (nonatomic, strong) FaceIndicatorLayer *faceIndicatorLayer;

@property (nonatomic, strong) UIView *flashView;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) IBOutlet UIView *previewView;

@property (nonatomic, strong) UIImage *hat;
@property (nonatomic, strong) UIImage *sunglasses;
@property (nonatomic, strong) UIImage *mouth;
@property (nonatomic, strong) UIImage *beard;
@property (nonatomic, strong) IBOutlet UIImageView *marc;


-(NSMutableArray*) getEnabledLayers;
-(void) removeLayer: (NSString*) layerToClean;

-(CGImageRef) imageFlipedHorizontal: (CGImageRef) frontCamImage;
-(void) displayPreviewImage: (CGImageRef) previewImage withMetadata: (NSDictionary*) metadata;


// find where the video box is positioned within the preview layer based on the video size and gravity
+ (CGRect)videoPreviewBoxForGravity:(NSString *)gravity frameSize:(CGSize)frameSize apertureSize:(CGSize)apertureSize;

@end
