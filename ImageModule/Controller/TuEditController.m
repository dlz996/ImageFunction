//
//  TuEditController.m
//  ImageModule
//
//  Created by 董立峥 on 2017/5/26.
//  Copyright © 2017年 芦苇科技. All rights reserved.
//

#import "TuEditController.h"

@interface TuEditController ()
{
    // 相册
    TuSDKCPAlbumComponent *_albumComponent;
    //编辑器
    TuSDKCPPhotoEditMultipleComponent *_photoEditMultipleComponent;
}
@end

@implementation TuEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = White_Color;
    [self showHubWithStatus:LSQString(@"lsq_initing", @"正在初始化")];
    [self StartBeautifyImage];
}

- (void)StartBeautifyImage{
    //TUSDK自定义图片选取
    _albumComponent =
    [TuSDKGeeV1 albumCommponentWithController:self
                                callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         // 获取图片错误
         if (error) {
             lsqLError(@"album reader error: %@", error.userInfo);
             return;
         }
         [self openEditMultipleWithController:controller result:result];
     }];
    
    [_albumComponent showComponent];
}
/** 对图片进行处理 */
- (void)openEditMultipleWithController:(UIViewController *)controller
                                result:(TuSDKResult *)result;
{
    if (!controller || !result) return;
    // 组件选项配置
    _photoEditMultipleComponent =
    [TuSDKGeeV1 photoEditMultipleWithController:controller
                                  callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         _albumComponent = nil;
         // 获取图片失败
         if (error) {
             lsqLError(@"editMultiple error: %@", error.userInfo);
             return;
         }
         [result logInfo];
     }];
     // 设置图片
    _photoEditMultipleComponent.inputImage = result.image;
    _photoEditMultipleComponent.inputTempFilePath = result.imagePath;
    _photoEditMultipleComponent.inputAsset = result.imageAsset;
    // 是否在组件执行完成后自动关闭组件 (默认:NO)
    _photoEditMultipleComponent.autoDismissWhenCompelted = YES;
    // 当上一个页面是NavigationController时,是否通过 pushViewController 方式打开编辑器视图 (默认：NO，默认以 presentViewController 方式打开）
    _photoEditMultipleComponent.autoPushViewController = YES;
    [_photoEditMultipleComponent showComponent];
}
/**
 *  编辑器水印
 *
 *  @return option;
 */
- (TuSDKWaterMarkOption *)waterMarkOption;
{
    TuSDKWaterMarkOption *option = [[TuSDKWaterMarkOption alloc] init];
    
    // 水印文字或者图片需要至少设置一个
    // 设置水印文字
    option.markText = @"董立峥";
    
    // 设置水印文字颜色
    option.markTextColor = [UIColor whiteColor];
    
    // 文字大小 (默认: 24 SP)
    option.markTextSize = 24;
    
    // 文字阴影颜色 (默认:[UIColor grayColor])
    option.markTextShadowColor = [UIColor grayColor];
    
    // 设置水印图片
    option.markImage = [UIImage imageNamed:@"sample_watermark.png"];
    
    // 文字和图片顺序 (仅当图片和文字都非空时生效，默认: 文字在右)
    option.markTextPosition = lsqMarkTextPositionRight;
    
    // 设置水印位置 (默认: lsqWaterMarkBottomRight)
    option.markPosition = lsqWaterMarkBottomRight;
    
    // 设置水印距离图片边距 (默认: 6dp)
    option.markMargin = 6;
    
    // 文字和图片间距 (默认: 2dp)
    option.markTextPadding = 5;
    
    return option;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
