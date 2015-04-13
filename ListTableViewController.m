//
//  ListTableViewController.m
//  List
//
//  Created by Maciej Stanik on 11/04/2015.
//  Copyright (c) 2015 Maciej Stanik. All rights reserved.
//

#import "ListTableViewController.h"
#import "Item.h"
#import "ItemCell.h"

@interface ListTableViewController () {
    NSManagedObjectContext *_context;
}

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (void)showData {
    _context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    _items = [[_context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ItemCell";
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Item *item = [_items objectAtIndex:indexPath.row];
    cell.itemNameLabel.text = item.name;
    [cell setChecked:item.checked];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_context deleteObject:[_items objectAtIndex:indexPath.row]];
        [_items removeObjectAtIndex:indexPath.row];
        NSError *saveError = nil;
        [_context save:&saveError];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     Item *item = [_items objectAtIndex:indexPath.row];
    item.checked = !item.checked;
    
    NSError *saveError = nil;
    [_context save:&saveError];
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark IBAction's

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add item" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *inputField = [alertView textFieldAtIndex:0];
        
        if (inputField.text.length > 0) {
            [self addItemWithName:inputField.text];
        }
    }
}

- (void)addItemWithName:(NSString *)itemName {
    NSManagedObjectContext *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:_context];
    [newItem setValue:itemName forKey:@"name"];
    
    NSError *saveError = nil;
    [_context save:&saveError];
    [self showData];
}

@end
