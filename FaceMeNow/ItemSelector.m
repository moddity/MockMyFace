//
//  ItemSelector.m
//  FaceMeNow
//
//  Created by Jaume Cornadó on 10/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import "ItemSelector.h"

@implementation ItemSelector

@synthesize catScroll, itemsArray, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


-(void) parseItems {
    
    NSString *categoriesFile = [[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"];
    
    NSDictionary *catDict = [NSDictionary dictionaryWithContentsOfFile:categoriesFile];
    
    [catDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSDictionary *category = (NSDictionary *) obj;
        
        UIButton *catButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [catButton setFrame:CGRectMake(CATEGORY_WIDTH*[[catDict allKeys] indexOfObject:key], 0, CATEGORY_WIDTH, CATEGORY_WIDTH)];
        [catButton setImage:[UIImage imageNamed:[category objectForKey:@"icon"]] forState:UIControlStateNormal];
        [catButton setTag:[[catDict allKeys] indexOfObject:key]];
        [catButton addTarget:self action:@selector(toogleItemsUP:) forControlEvents:UIControlEventTouchUpInside];
        [catScroll addSubview:catButton];
        
        NSLog(@"CAT: %@", category);
        
        [self.itemsArray addObject:[category objectForKey:@"items"]];
        
        NSLog(@"ITEMS ARRAY: %@", self.itemsArray);
        
    }];
   
}

-(void) loadItems: (NSArray*) items {
    
    //Treiem els botons anteriors si n'hi ha
    if([itemsButtons count] > 0) {
        for(UIButton *b in itemsButtons) {
            [b removeFromSuperview];
        }
    }
    
    for(NSDictionary *itemDict in items) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setFrame:CGRectMake(ITEM_WIDTH*[items indexOfObject:itemDict], 0, ITEM_WIDTH, ITEM_WIDTH)];
        [itemButton setImage:[UIImage imageNamed:[itemDict objectForKey:@"image"]] forState:UIControlStateNormal];
        [itemButton setTag:[items indexOfObject:itemDict]];
        [itemButton addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [itemScroll addSubview:itemButton];
        
        [itemsButtons addObject:itemButton];
    }
    activeItems = items;
}

-(void) selectItem:(id)sender {
    UIButton *origin = (UIButton*) sender;
    int itemsIndex = origin.tag;
    
    NSDictionary *itemDict = [activeItems objectAtIndex:itemsIndex];
    
    int itemType = [[itemDict objectForKey:@"type"] intValue];
    
    [delegate itemSelected: itemType imageName: [itemDict objectForKey:@"image"]];
}

-(IBAction) toogleItemsUP:(id) sender {
   if(!itemsUP) {
       
       //Load buttons
       
       UIButton *origin = (UIButton*) sender;
       
       int catIndex = origin.tag;
       
       [self loadItems:[itemsArray objectAtIndex:catIndex]];
       
        [UIView animateWithDuration:0.3
                         animations:^{ 
                             CGPoint center = self.view.center;
                             center.y -= 81;
                             self.view.center = center;
                         } 
                         completion:^(BOOL finished){
                             itemsUP = YES;
                         }];
    } else {
        [UIView animateWithDuration:0.3
                         animations:^{ 
                             CGPoint center = self.view.center;
                             center.y += 81;
                             self.view.center = center;
                         } 
                         completion:^(BOOL finished){
                             itemsUP = NO;
                         }];
    }
    
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
