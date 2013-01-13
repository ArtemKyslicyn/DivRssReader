//
//  RSSCell.m
//  DivRssReader
//
//  Created by Artem Kislitsyn on 10.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import "RSSCell.h"

@implementation RSSCell
@synthesize lblTitle;
@synthesize lblDate;
@synthesize lblDesc;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWithRssItem:(RSSItem*)item{
    self.lblTitle.text = item.title;
    //Set height for title calculted in item
    CGRect lblTitleRect = lblTitle.frame;
    lblTitleRect.size.height = [item titleHeight];
    self.lblTitle.frame=lblTitleRect;
    
    lblDate.text = item.pubDate;
    CGRect lblDateRect = lblDate.frame;
    //Set height for date calculted in item
    lblDateRect.size.height = [item pubDateHeight];
    lblDateRect.origin.y = lblTitle.frame.origin.y + lblTitle.frame.size.height;
    self.lblDate.frame = lblDateRect;
    
    lblDesc.text = item.descript;
    //Set height for Description calculted in item
    CGRect lblDescRect = lblDesc.frame;
    lblDescRect.size.height = [item descriptHeight];
    lblDescRect.origin.y = lblDate.frame.origin.y + lblDate.frame.size.height;
    self.lblDesc.frame = lblDescRect;
}

@end
