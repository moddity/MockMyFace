//
//  ItemSelector.h
//  MockMyFace
//
//  Created by Jaume Cornadó on 10/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CATEGORY_WIDTH 56
#define ITEM_WIDTH 75
#define ITEM2_WIDTH 85
#define ITEMS_OFFSET 150
#define MARGIN_LEFT 40
#define kItemTypeHat 1
#define kItemTypeSunglasses 2
#define kItemTypeMouth 3
#define kItemTypeMarc 4

#define kBackViewTAG 2020

@protocol ItemSelectorDelegate <NSObject>
//Comunicates to the main object that item is selected
-(void) itemSelected: (int) kItemType imageName: (NSString*) imgName;
//When the photo button is pressed
-(void) takePhoto;
//When the clear button is pressed
-(void) clearMocks;

@end


@interface ItemSelector : UIViewController {
    IBOutlet UIScrollView *itemScroll;
    IBOutlet UIImageView *slideBackground;
    
    BOOL itemsUP;
 
    NSMutableArray *itemsArray;
    NSMutableArray *itemsButtons;
    NSArray *activeItems;
    
    int selectedCategoryIndex;
}

@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, weak) id<ItemSelectorDelegate> delegate;
@property (nonatomic, strong) NSDictionary *catDict;
@property (nonatomic, assign) UIButton *buttonSelected;

//Read plist of items
-(void) parseItems;
//Called when a user shakes the phone
-(void) getRandomItems;
//Category selected
-(IBAction) toogleItemsUP:(id) sender;
//Create item views
-(void) loadItems: (NSArray*) items;
//Fired when user touches an item
-(void) selectItem: (id) sender;
//Sends the buttons up
-(void) animateButton: (UIButton*) newButton;
//The button hooks
-(IBAction) takePhotoAction: (id) sender;
-(IBAction) cleanAction: (id) sender;

@end
