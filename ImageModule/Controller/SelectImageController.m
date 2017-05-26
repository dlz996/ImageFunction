//
//  SelectImageController.m
//  ImageModule
//
//  Created by 董立峥 on 2017/5/24.
//  Copyright © 2017年 芦苇科技. All rights reserved.
//

#import "SelectImageController.h"

@interface SelectImageController ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SelectImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择照片";
    self.view.backgroundColor = White_Color;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto)
     {
         if (photos.count>1){
             NSMutableArray * imageArray = [NSMutableArray array];
             for (int i=0; i<photos.count; i++) {
                 UIImageView * image = [[UIImageView alloc]initWithImage:photos[i]];
                 [self.view addSubview:image];
                 [imageArray addObject:image];
             }
             [imageArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
             [imageArray mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.offset(64);
                 make.width.offset(50);
                 make.height.offset(50);
             }];
         }else if(photos.count==1 ){
             UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
             imageView.image = photos[0];
             [self.view addSubview:imageView];
         }
     }];
    imagePickerVc.navigationBar.barTintColor = Blue_Color;
    // 设置是否可以选择视频/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];


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
