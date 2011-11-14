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


@class CIDetector;

@interface FaceMeNowViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate, ItemSelectorDelegate> {
    
    IBOutlet UIView *previewView;
    AVCaptureVideoPreviewLayer *previewLayer;
	AVCaptureVideoDataOutput *videoDataOutput;
	dispatch_queue_t videoDataOutputQueue;
	AVCaptureStillImageOutput *stillImageOutput;
	UIView *flashView;
	UIImage *square;
	BOOL isUsingFrontFacingCamera;
	CIDetector *faceDetector;
	CGFloat beginGestureScale;
	CGFloat effectiveScale;
    IBOutlet ItemSelector *itemSelectorViewController;
    
    //ImageMasks
    UIImage *hat;
    UIImage *sunglasses;
    UIImage *mouth;
    
}

@property (nonatomic, strong) IBOutlet ItemSelector *itemSelectorViewController;

@end
