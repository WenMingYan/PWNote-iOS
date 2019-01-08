//
//  PWBigTitleViewModel.h
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWViewModel.h"

extern CGFloat const kBigTitleViewHeight;

@interface PWBigTitleViewModel : PWViewModel

@property (nonatomic, copy) NSString *bigTitle; /**< 大标题  */
@property (nonatomic, copy) NSString *subTitle; /**< 副标题  */

@end
