//
//  MockCameraViewController.h
//  MockMyFace
//
//  Created by Jaume Cornadó on 10/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ItemSelector.h"
#import "ViewAndShareController.h"
#import "FaceIndicatorLayer.h"
#import "MBProgressHUD.h"

#define kSunglassesLayer @"SunglassesLayer"
#define kHatLayer @"HatLayer"
#define kMouthLayer @"MouthLayer"

@class CIDetector;
@class AdWhirlView;

extern const CGBitmapInfo kDefaultCGBitmapInfo;
extern const CGBitmapInfo kDefaultCGBitmapInfoNoAlpha;

//adwihrl key 7e4323992fd8465cbf0138153f04ea52

@interface MockCameraViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate, ItemSelectorDelegate> {
	
	dispatch_queue_t videoDataOutputQueue;
	
	BOOL isUsingFrontFacingCamera;
	CIDetector *faceDetector;
	CGFloat beginGestureScale;
	CGFloat effectiveScale;
}

@property (nonatomic, strong) IBOutlet ItemSelector *itemSelectorViewController;
@property (nonatomic, strong) ViewAndShareController *previewController;
@property (nonatomic, strong) FaceIndicatorLayer *faceIndicatorLayer;

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) IBOutlet UIView *previewView;

@property (nonatomic, strong) UIImage *hat;
@property (nonatomic, strong) UIImage *sunglasses;
@property (nonatomic, strong) UIImage *mouth;
@property (nonatomic, strong) IBOutlet UIImageView *marc;


/* Gets the items enabled to mock */
-(NSMutableArray*) getEnabledLayers;
/* Removes item from the screen */
-(void) removeLayer: (NSString*) layerToClean;
/* Flips images by frontcam */
-(CGImageRef) imageFlipedHorizontal: (CGImageRef) frontCamImage;
/* Returns an image of 480x320 */
-(CGImageRef) imageSized: (CGImageRef) backCamImage;
/* Loads the preview controller, to save, share or discard the image */
-(void) displayPreviewImage: (CGImageRef) previewImage withMetadata: (NSDictionary*) metadata;
/* Changes the device camera */
-(void) setFrontCamera: (BOOL) isFront;
/* Reset the video device */
-(void) restartVideoCapture;
/* Utility method to flip coordinates of a rect */
-(CGRect) flipRect: (CGRect) rectToFlip;

// find where the video box is positioned within the preview layer based on the video size and gravity
+ (CGRect)videoPreviewBoxForGravity:(NSString *)gravity frameSize:(CGSize)frameSize apertureSize:(CGSize)apertureSize;

//Functions to calculate item positions
-(CGRect) getHatRectFromFace: (CIFaceFeature*) face isStill: (BOOL) still;
-(CGRect) getMouthRectFromFace: (CIFaceFeature*) face isStill: (BOOL) still;
-(CGRect) getSunglassesRectFromFace: (CIFaceFeature*) face isStill: (BOOL) still;

@end
