//
//  MovieCellTableViewCell.h
//  Flixer
//
//  Created by gilemos on 6/26/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;

@end

NS_ASSUME_NONNULL_END
