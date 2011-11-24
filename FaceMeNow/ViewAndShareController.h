//
//  ViewAndShareController.h
//  MockMe
//
//  Created by Jaume Cornadó on 22/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewAndShareController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *previewImage;

-(IBAction) close: (id) sender;
-(IBAction) openShareView:(id)sender;

@end
