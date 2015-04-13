//
//  ItemCell.m
//  List
//
//  Created by Maciej Stanik on 13/04/2015.
//  Copyright (c) 2015 Maciej Stanik. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (void)awakeFromNib {
    [_checkImage setImage:[UIImage imageNamed:@"Empty"]];
}

- (void)setChecked:(BOOL)checked {
    if (checked) {
        [_checkImage setImage:[UIImage imageNamed:@"Check"]];
    } else {
        [_checkImage setImage:[UIImage imageNamed:@"Empty"]];
    }
}

@end
