//
//  ItemSelector.h
//  FaceMeNow
//
//  Created by Jaume Cornadó on 10/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CATEGORY_WIDTH 44
#define ITEM_WIDTH 75

#define kItemTypeHat 1
#define kItemTypeSunglasses 2
#define kItemTypeMouth 3


@protocol ItemSelectorDelegate <NSObject>

-(void) itemSelected: (int) kItemType imageName: (NSString*) imgName;

@end


@interface ItemSelector : UIViewController {
    IBOutlet UIScrollView *catScroll;
    IBOutlet UIScrollView *itemScroll;
    BOOL itemsUP;
 
    NSMutableArray *itemsArray;
    NSMutableArray *itemsButtons;
    NSArray *activeItems;
    
    int selectedCategoryIndex;
}

@property (nonatomic, strong) IBOutlet UIScrollView *catScroll;
@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, weak) id<ItemSelectorDelegate> delegate;


-(void) parseItems;
-(IBAction) toogleItemsUP:(id) sender;


-(void) loadItems: (NSArray*) items;
-(void) selectItem: (id) sender;

@end
