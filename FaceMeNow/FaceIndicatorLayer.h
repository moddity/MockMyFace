//
//  FaceIndicatorLayer.h
//  MockMe
//
//  Created by Jaume Cornadó on 28/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNoFacesMessage @"No faces found! Please look at the cam and smile!"
#define kNoMocksEnabled @"No items enabled! Select any item or shake for random mockup!"


@interface FaceIndicatorLayer : UIViewController

@property (strong, nonatomic) IBOutlet UIView *blackBackLayer;
@property (strong, nonatomic) IBOutlet UILabel *helperText;


-(void) displayMessage: (BOOL) display withText: (NSString*) text;

@end
