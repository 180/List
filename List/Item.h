//
//  Item.h
//  List
//
//  Created by Maciej Stanik on 11/04/2015.
//  Copyright (c) 2015 Maciej Stanik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic) BOOL checked;
@property (nonatomic, retain) NSString *name;

@end
