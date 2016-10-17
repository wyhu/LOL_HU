//
//  ViewController.m
//  LOL_HU
//
//  Created by huweiya on 16/7/12.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"



#define kwidth self.view.bounds.size.width

#define kheight self.view.bounds.size.height


@interface ViewController ()
<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,  strong) UITableView *mainTableView;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self.view addSubview:self.mainTableView];
    
    
}


#pragma mark 主单元格
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:1];
        
        _mainTableView.dataSource = self;
        
        _mainTableView.delegate = self;
        
        _mainTableView.tableHeaderView = [self headView];
    }
    
    return _mainTableView;
}


#pragma mark 单元格头

- (UIView *)headView{
    
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kwidth, 100)];
    
    UIButton *refresh = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    refresh.center = head.center;
    
    [head addSubview:refresh];
    
    [refresh addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return head;
    
}

- (void)btnAction:(UIButton *)btn
{
    // My API (GET http://ossweb-img.qq.com/upload/qqtalk/lol_hero/hero_list.js)
    
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Create request
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"http://ossweb-img.qq.com/upload/qqtalk/lol_hero/hero_list.js" parameters:nil error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                    
                                                                             
                                                                             NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
                                                                             NSLog(@"HTTP Response Body: %@", responseObject);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];

}



#pragma mark 组数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 个数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

#pragma mark 单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *inde = @"lol";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inde];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    
    return cell;
}



@end
