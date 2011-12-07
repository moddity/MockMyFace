//
//  ItemSelector.h
//  FaceMeNow
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

-(void) itemSelected: (int) kItemType imageName: (NSString*) imgName;
-(void) takePhoto;
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


-(void) parseItems;
-(void) getRandomItems;
-(IBAction) toogleItemsUP:(id) sender;


-(void) loadItems: (NSArray*) items;
-(void) selectItem: (id) sender;

-(void) animateButton: (UIButton*) newButton;

-(IBAction) takePhotoAction: (id) sender;
-(IBAction) cleanAction: (id) sender;

@end
