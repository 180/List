//
//  ItemCell.h
//  List
//
//  Created by Maciej Stanik on 13/04/2015.
//  Copyright (c) 2015 Maciej Stanik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;

- (void)setChecked:(BOOL)checked;

@end
