//
//  TYDFCenterCollectionView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDeviceFuctionModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYDFCenterCollectionView : UIView

//TODO: wmy 暂时先设置该delegate之后中间部分显示需要从中拿出
@property(nonatomic, weak) id<TYDeviceFunctionDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
