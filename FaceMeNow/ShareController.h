//
//  ShareController.h
//  MockMe
//
//  Created by Jaume Cornadó on 25/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareControllerDelegate <NSObject>

-(void) backFromShare;
-(void) tweetAction;
-(void) emailAction;
@end


@interface ShareController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *mailButton;
@property (strong, nonatomic) IBOutlet UIButton *tweetButton;
@property (strong, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) id<ShareControllerDelegate> delegate;


-(IBAction)backButtonAction:(id)sender;
-(IBAction)tweetButtonAction:(id)sender;
-(IBAction)emailButtonAction:(id)sender;
-(IBAction)fbButtonAction:(id)sender;

@end
