//
//  RSSCell.h
//  DivRssReader
//
//  Created by Artem Kislitsyn on 10.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSItem.h"
@interface RSSCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
-(void)configureCellWithRssItem:(RSSItem*)item;
@end
