//
//  ListTableViewController.h
//  List
//
//  Created by Maciej Stanik on 11/04/2015.
//  Copyright (c) 2015 Maciej Stanik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewController : UITableViewController

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender;

@property (strong) NSMutableArray *items;

@end
