//
//  ViewAndShareController.m
//  MockMe
//
//  Created by Jaume Cornadó on 22/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import "ViewAndShareController.h"

@implementation ViewAndShareController
@synthesize previewImage, imageMetatadata, shareController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPreviewImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)close:(id)sender {
    [[self view] removeFromSuperview];
}

-(IBAction)openShareView:(id)sender {
    self.shareController = [[ShareController alloc] initWithNibName:@"ShareController" bundle:nil];
    self.shareController.view.frame = self.view.frame;
    self.shareController.delegate = self;
    [self.view addSubview:self.shareController.view];
}

-(void) backFromShare {
    [self.shareController.view removeFromSuperview];
}

-(void) tweetAction {
    TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
    
    [tweetSheet setInitialText:@"Look at my funny face! #mockmyface"];
    
    [tweetSheet addImage:self.previewImage.image];
    
    tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        [self dismissModalViewControllerAnimated:YES];
    };
    [self presentModalViewController:tweetSheet animated:YES];
}

-(IBAction)saveToCameraRoll:(id)sender {
    [self writeCGImageToCameraRoll:[previewImage.image CGImage] withMetadata:imageMetatadata];
}
// utility routine used after taking a still image to write the resulting image to the camera roll
- (BOOL)writeCGImageToCameraRoll:(CGImageRef)cgImage withMetadata:(NSDictionary *)metadata
{
	CFMutableDataRef destinationData = CFDataCreateMutable(kCFAllocatorDefault, 0);
	CGImageDestinationRef destination = CGImageDestinationCreateWithData(destinationData, 
																		 CFSTR("public.jpeg"), 
																		 1, 
																		 NULL);
	BOOL success = (destination != NULL);
    
    //ERROR
    if(!success) {
        if (destinationData)
            CFRelease(destinationData);
        if (destination)
            CFRelease(destination);
        return success;
    }
    
	const float JPEGCompQuality = 1.0f; // JPEGHigherQuality
	CFMutableDictionaryRef optionsDict = NULL;
	CFNumberRef qualityNum = NULL;
	
	qualityNum = CFNumberCreate(0, kCFNumberFloatType, &JPEGCompQuality);    
	if ( qualityNum ) {
		optionsDict = CFDictionaryCreateMutable(0, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
		if ( optionsDict )
			CFDictionarySetValue(optionsDict, kCGImageDestinationLossyCompressionQuality, qualityNum);
		CFRelease( qualityNum );
	}
	
	CGImageDestinationAddImage( destination, cgImage, optionsDict );
	success = CGImageDestinationFinalize( destination );
    
	if ( optionsDict )
		CFRelease(optionsDict);
	
    //ERROR
    if(!success) {
        if (destinationData)
            CFRelease(destinationData);
        if (destination)
            CFRelease(destination);
        return success;
    }
    
	
	CFRetain(destinationData);
	ALAssetsLibrary *library = [ALAssetsLibrary new];
	[library writeImageDataToSavedPhotosAlbum:(__bridge id)destinationData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
		if (destinationData)
			CFRelease(destinationData);
	}];
	
    
    return success;
}


@end
