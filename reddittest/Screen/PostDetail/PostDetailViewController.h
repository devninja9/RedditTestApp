//
//  PostDetailViewController.h
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostEntity;
@class PostCell;

NS_ASSUME_NONNULL_BEGIN

@interface PostDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) PostEntity *post;

@end

NS_ASSUME_NONNULL_END
