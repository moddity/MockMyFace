//
//  ItemSelector.m
//  FaceMeNow
//
//  Created by Jaume Cornadó on 10/11/11.
//  Copyright (c) 2011 Bazinga Systems. All rights reserved.
//

#import "ItemSelector.h"

@implementation ItemSelector

@synthesize catScroll;

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
        [catButton setFrame:CGRectMake(44*[[catDict allKeys] indexOfObject:key], 0, 44, 44)];
        [catButton setImage:[UIImage imageNamed:[category objectForKey:@"icon"]] forState:UIControlStateNormal];
        [catButton setTag:[[catDict allKeys] indexOfObject:key]];
        [catButton addTarget:self action:@selector(toogleItemsUP:) forControlEvents:UIControlEventTouchUpInside];
        [catScroll addSubview:catButton];
        
        
    }];
   
}
 
 

-(IBAction) toogleItemsUP:(id) sender {
   if(!itemsUP) {
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
