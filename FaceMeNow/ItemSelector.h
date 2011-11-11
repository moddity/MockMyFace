//
//  ItemSelector.h
//  FaceMeNow
//
//  Created by Jaume Cornadó on 10/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemSelector : UIViewController {
    IBOutlet UIScrollView *catScroll;
    IBOutlet UIScrollView *itemScroll;
    BOOL itemsUP;
   
}

@property (nonatomic, strong) IBOutlet UIScrollView *catScroll;

-(void) parseItems;
-(IBAction) toogleItemsUP:(id) sender;

@end
