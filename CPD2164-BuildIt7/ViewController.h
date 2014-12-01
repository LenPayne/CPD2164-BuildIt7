//
//  ViewController.h
//  CPD2164-BuildIt7
//
//  Created by Len Payne on 2014-11-28.
//  Copyright (c) 2014 Len Payne. All rights reserved.
//

#import <UIKit/UIKit.h>

// Declare a helper function that you will use to get a path
// to the location on disk where you can save the to-do list
NSString* DocPath(void);

@interface ViewController : UIViewController <UITableViewDataSource>
@property (nonatomic) UITableView *taskTable;
@property (nonatomic) UITextField *taskField;
@property (nonatomic) UIButton *insertButton;

@property (nonatomic) NSMutableArray *tasks;

- (void)addTask:(id)sender;
- (void)saveTasks;

@end

