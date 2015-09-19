//
//  ViewController.m
//  WSCoreSpotLight-Demo
//
//  Created by Wilson-Yuan on 15/9/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "ViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>

#import "WSSpotLightHelper.h"

@interface ViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic, strong) NSMutableArray *nameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self;
    self.textField.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    [[WSSpotLightHelper helper] deleteAllSearchAbleItems];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.nameArray[indexPath.row];
    return cell;
}


#pragma mark - UITextField Delegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text) {
        [self.nameArray addObject:textField.text];
        [self.tableView reloadData];
        
        [[WSSpotLightHelper helper] addNameToCoreSearchWithName:textField.text];
        
        textField.text = nil;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}


- (IBAction)addButtonAction:(id)sender {
    
    [self.textField resignFirstResponder];
}

- (NSMutableArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = [NSMutableArray new];
    }
    return _nameArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
