//
//  FaceIndicatorLayer.m
//  MockMe
//
//  Created by Jaume Cornadó on 28/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import "FaceIndicatorLayer.h"
#import <QuartzCore/QuartzCore.h>

@implementation FaceIndicatorLayer
@synthesize blackBackLayer;
@synthesize helperText;

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
    [blackBackLayer.layer setCornerRadius:5.0];
}

- (void)viewDidUnload
{
    [self setBlackBackLayer:nil];
    [self setHelperText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
