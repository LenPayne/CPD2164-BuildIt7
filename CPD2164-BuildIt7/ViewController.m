//
//  ViewController.m
//  CPD2164-BuildIt7
//
//  Created by Len Payne on 2014-11-28.
//  Copyright (c) 2014 Len Payne. All rights reserved.
//

#import "ViewController.h"

// Helper function to fetch the path to our to-do data stored on disk
NSString *DocPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
    return [pathList[0] stringByAppendingPathComponent:@"data.td"];
}

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Application Callbacks

- (void)viewDidLoad {
    // Load an existing dataset or create a new one
    NSArray *pList = [NSArray arrayWithContentsOfFile:DocPath()];
    if (pList) {
        // We have a dataset; copy it into tasks
        self.tasks = [pList mutableCopy];
    }
    else {
        // There is no dataset; create an empty array
        self.tasks = [NSMutableArray array];
    }
    
    // NOTE: This code is happening in the ViewController, because that is the correct place to put it.
    // As such, references from the text of self.window and winFrame are replaced with self.view and self.view.frame
    
    // Determine the Size of the UI Objects
    CGRect tableFrame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 100);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    
    // Initialize the UITableView based on the Frame
    self.taskTable = [[UITableView alloc] initWithFrame:tableFrame
                                                  style:UITableViewStylePlain];
    self.taskTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Tell the table which class to instantiate whenever it needs a new cell
    [self.taskTable registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"Cell"];
    
    // Make the UIViewController the table view's dataSource
    self.taskTable.dataSource = self;

    // Create and configure the UITextField instance where new tasks will be entered
    self.taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    self.taskField.borderStyle = UITextBorderStyleRoundedRect;
    self.taskField.placeholder = @"Type a task, tap Insert";
    
    // Create and configure the UIButton instance
    self.insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.insertButton.frame = buttonFrame;
    
    // Give the Button a Title
    [self.insertButton setTitle:@"Insert"
                       forState:UIControlStateNormal];
    
    // Set the target and action for the Insert Button
    [self.insertButton addTarget:self
                          action:@selector(addTask:)
                forControlEvents:UIControlEventTouchUpInside];
    
    // Add our Three UI Elements to the View Controller
    [self.view addSubview:self.taskTable];
    [self.view addSubview:self.taskField];
    [self.view addSubview:self.insertButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (void) addTask:(id)sender {
    // Get the task
    NSString *text = [self.taskField text];
    
    // Quit here if taskField is empty
    if ([text length] == 0) {
        return;
    }
    
    // Log text to Console - Left in for Debugging Purposes
    NSLog(@"Task Entered: %@", text);
    
    // Add it to the working array
    [self.tasks addObject:text];
    
    // Refresh the table so that the new item shows up
    [self.taskTable reloadData];
    
    // Clear out the text field
    [self.taskField setText:@""];
    
    // Dismiss the Keyboard
    [self.taskField resignFirstResponder];
}


// This method is called from the AppDelegate
// NOTE: On Simulator, Only Saves When you Hit Home (Cmd-Shift-H) not when App Force-Stopped
- (void)saveTasks {
    // Save our tasks array to the disk when the app is closing
    [self.tasks writeToFile:DocPath() atomically:YES];
}

#pragma mark - Table View Management

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
    // Because this table view only has one section,
    // the number of rows in it is equal to the
    // number of items in the tasks array
    return [self.tasks count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // To improve performance, this method first checks
    // for an existing cell object that we can reuse
    // If there isn't one, then a new cell is created
    UITableViewCell* c = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Then we (re)configure the cell based on the model object,
    // in this case the tasks array, ...
    NSString* item = [self.tasks objectAtIndex:indexPath.row];
    c.textLabel.text = item;
    
    // ... and hand the properly configured cell back to the table view
    return c;
}

@end
