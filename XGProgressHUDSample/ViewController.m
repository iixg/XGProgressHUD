//
//  ViewController.m
//  XGProgressHUDSample
//
//  Created by iixg on 2022/1/6.
//

#import "ViewController.h"
#import "Sample1ViewController.h"
#import "Sample2ViewController.h"
#import "Sample3ViewController.h"
#import "Sample4ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *datasource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"XGProgressHUD";
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    [self.view addSubview:tableview];
    
    datasource = @[@"loading", @"loading with the message", @"loading & toast", @"toast"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    if (cell) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = datasource[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    XGBaseViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [Sample1ViewController new];
            break;
        case 1:
            vc = [Sample2ViewController new];
            break;
        case 2:
            vc = [Sample3ViewController new];
            break;
        case 3:
            vc = [Sample4ViewController new];
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
