//
//  ShareController.m
//  MockMe
//
//  Created by Jaume Cornadó on 25/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import "ShareController.h"

@implementation ShareController
@synthesize backButton;
@synthesize mailButton;
@synthesize tweetButton;
@synthesize facebookButton;
@synthesize delegate;
@synthesize backgroundView;
@synthesize sheetBackground;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
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
    backgroundView.alpha = 0.0;
   
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    backgroundView.alpha = 0.0;
    
    sheetBackground.frame = CGRectMake(0, -218, 320, 218);
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
           sheetBackground.frame = CGRectMake(0, 0, 320, 218);
        }];
    }];
    
    
}

- (void)viewDidUnload
{
    [self setBackButton:nil];
    [self setMailButton:nil];
    [self setTweetButton:nil];
    [self setFacebookButton:nil];
    [self setBackgroundView:nil];
    [self setSheetBackground:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)backButtonAction:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        sheetBackground.frame = CGRectMake(0, -218, 320, 218);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
             backgroundView.alpha = 0.0;
             [delegate backFromShare];
        }];
    }];
}

-(IBAction)tweetButtonAction:(id)sender {
    [delegate tweetAction];
}

-(IBAction)emailButtonAction:(id)sender {
    [delegate emailAction];
}

-(IBAction)fbButtonAction:(id)sender {
    [delegate fbAction];
}

@end
