//
//  SecondTableViewController.m
//  MoreTableView
//
//  Created by 刘伟强 on 2020/12/30.
//

// import分组次序：Frameworks、Services、UI
#import "SecondTableViewController.h"

#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

@interface SecondTableViewController ()

#pragma mark - 私有属性

@end

@implementation SecondTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - Events

#pragma mark - UITextFieldDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}



#pragma mark - UIOtherComponentDelegate

#pragma mark - Custom Delegates

#pragma mark - Public Methods

#pragma mark - Private Methods



#pragma mark - Getters and Setters

@end
