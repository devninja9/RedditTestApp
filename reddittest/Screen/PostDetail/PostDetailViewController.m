//
//  PostDetailViewController.m
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

#import "PostDetailViewController.h"
#import "reddittest-Swift.h"

@interface PostDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PostDetailViewController

NSString *cellID = @"PostCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    self.navigationItem.title = @"Post Detail";

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   return [PostCell heightForCellWithData:self.post width: tableView.bounds.size.width];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setPostWithData:self.post];
    
    return cell;
}

@end
