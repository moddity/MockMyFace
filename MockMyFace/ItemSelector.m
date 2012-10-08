//
//  ItemSelector.m
//  MockMyFace
//
//  Created by Jaume Cornadó on 10/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import "ItemSelector.h"
#import <QuartzCore/QuartzCore.h>

@implementation ItemSelector


@synthesize itemsArray, delegate, catDict, buttonSelected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


-(void) parseItems {
    
    NSString *categoriesFile = [[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"];
    
    catDict = [NSDictionary dictionaryWithContentsOfFile:categoriesFile];
    
    [catDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSDictionary *category = (NSDictionary *) obj;
        
        UIButton *catButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [catButton setFrame:CGRectMake(MARGIN_LEFT+(CATEGORY_WIDTH*[[catDict allKeys] indexOfObject:key]), 110, CATEGORY_WIDTH, CATEGORY_WIDTH)];
        [catButton setImage:[UIImage imageNamed:[category objectForKey:@"icon"]] forState:UIControlStateNormal];
        [catButton setTag:[[catDict allKeys] indexOfObject:key]];
        [catButton addTarget:self action:@selector(toogleItemsUP:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:catButton];
         
        
        [self.itemsArray addObject:[category objectForKey:@"items"]];
        
    }];
   
}

-(void) loadItems: (NSArray*) items {
    
    //If there is any button remove it
    if([itemsButtons count] > 0) {
        for(UIButton *b in itemsButtons) {
            [b removeFromSuperview];
        }
        [itemsButtons removeAllObjects];
    }
    
    for(UIView *v in [itemScroll subviews]) {
        if(v.tag == kBackViewTAG)
            [v removeFromSuperview];
    }
    
    float itemX = 10;
    
    for(NSDictionary *itemDict in items) {
        
        CGRect itemFrame = CGRectMake(itemX, 10, ITEM_WIDTH, ITEM_WIDTH);
        
        UIView *backView = [[UIView alloc] initWithFrame:itemFrame];
        backView.tag = kBackViewTAG;
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.masksToBounds = NO;
        backView.layer.cornerRadius = 8; // if you like rounded corners
        backView.layer.shadowOffset = CGSizeMake(5, -5);
        backView.layer.shadowRadius = 5;
        backView.layer.shadowOpacity = 0.5;
        
        [itemScroll addSubview:backView];
        
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setFrame:itemFrame];
        
        NSString *thumbName = [NSString stringWithFormat:@"thumb_%@", [itemDict objectForKey:@"image"]];
        
        [itemButton setImage:[UIImage imageNamed:thumbName] forState:UIControlStateNormal];
        [itemButton setTag:[items indexOfObject:itemDict]];
        
        
        itemButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [itemButton addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [itemScroll addSubview:itemButton];
        
        [itemsButtons addObject:itemButton];
        
        itemX += ITEM_WIDTH + 10;
    }
    
    [itemScroll setContentSize:CGSizeMake(itemX, itemScroll.frame.size.height)];
    [itemScroll setContentOffset:CGPointMake(0, 0)];
    activeItems = items;
}

-(void) getRandomItems {
    
    for(NSArray *items in itemsArray) {
        int value = arc4random() % [items count];
        
        NSDictionary *itemDict = [items objectAtIndex:value];
        
        int itemType = [[itemDict objectForKey:@"type"] intValue];
        
        [delegate itemSelected:itemType imageName:[itemDict objectForKey:@"image"]];
    }
}


-(void) selectItem:(id)sender {
    UIButton *origin = (UIButton*) sender;
    int itemsIndex = origin.tag;
    
    NSDictionary *itemDict = [activeItems objectAtIndex:itemsIndex];
    
    int itemType = [[itemDict objectForKey:@"type"] intValue];
    
    [delegate itemSelected: itemType imageName: [itemDict objectForKey:@"image"]];
    selectedCategoryIndex = -1;
    [self toogleItemsUP:sender];
    [self animateButton:nil];
}

-(IBAction) toogleItemsUP:(id) sender {
    
    UIButton *origin = (UIButton*) sender;
    if (selectedCategoryIndex != -1 || buttonSelected == nil) {
        [self animateButton:origin];
    } 
    
   if(!itemsUP) {
       //Load buttons
       
       selectedCategoryIndex = origin.tag;
       
       [self loadItems:[itemsArray objectAtIndex:selectedCategoryIndex]];
       origin.enabled = NO;
       [UIView animateWithDuration:0.3
                        animations:^{ 
                            itemScroll.center = CGPointMake(itemScroll.center.x, itemScroll.center.y-ITEMS_OFFSET);
                            slideBackground.center = CGPointMake(slideBackground.center.x, slideBackground.center.y-ITEMS_OFFSET);
                         } 
                         completion:^(BOOL finished){
                            itemsUP = YES;
                             origin.enabled = YES;
                         }];
       
    } else {
        
        //Category change
        
        if(selectedCategoryIndex >= 0 && origin.tag != selectedCategoryIndex) {
            selectedCategoryIndex = origin.tag;
            [self loadItems:[itemsArray objectAtIndex:selectedCategoryIndex]];
            return;
        }
        
        origin.enabled = NO;
        [UIView animateWithDuration:0.3
                         animations:^{ 
                             itemScroll.center = CGPointMake(itemScroll.center.x, itemScroll.center.y+ITEMS_OFFSET);
                             
                             slideBackground.center = CGPointMake(slideBackground.center.x, slideBackground.center.y+ITEMS_OFFSET);
                         } 
                         completion:^(BOOL finished){
                             itemsUP = NO;
                             origin.enabled = YES;
                         }];
    }
}

-(void) animateButton:(UIButton *)newButton {
    
    if(buttonSelected != nil && newButton != buttonSelected) {
        [UIView animateWithDuration:0.2 animations:^{
            buttonSelected.frame = CGRectInset(buttonSelected.frame, ITEM_WIDTH-CATEGORY_WIDTH, ITEM_WIDTH-CATEGORY_WIDTH);
        }];
    }
    
    if(newButton != buttonSelected && newButton != nil) {
        [UIView animateWithDuration:0.2 animations:^{
            newButton.frame = CGRectInset(newButton.frame, CATEGORY_WIDTH-ITEM_WIDTH, CATEGORY_WIDTH-ITEM_WIDTH);
        }];
    }
    
    buttonSelected = newButton;
}

-(IBAction)cleanAction:(id)sender {
    [delegate clearMocks];
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
  
    itemsArray = [NSMutableArray array];
    itemsButtons = [NSMutableArray array];
    
    itemsUP = NO;
  
    [self parseItems];
  
    slideBackground.center = CGPointMake(slideBackground.center.x, slideBackground.center.y+168);
    
}

-(IBAction)takePhotoAction:(id)sender {
    [delegate takePhoto];
}

- (void)viewDidUnload
{
  
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
