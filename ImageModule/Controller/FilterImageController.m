//
//  FilterImageController.m
//  ImageModule
//
//  Created by 董立峥 on 2017/5/24.
//  Copyright © 2017年 芦苇科技. All rights reserved.
//

#import "FilterImageController.h"

@interface FilterImageController ()
@property (nonatomic,strong)UIImage * inputImage;
@end

@implementation FilterImageController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"滤镜";
    [self.view setBackgroundColor:White_Color];

    [self FiterImage];
}

/** 滤镜 */
- (void)FiterImage{
    
    self.inputImage = [UIImage imageNamed:@"image"];
    //使用黑白素描滤镜
    GPUImageSketchFilter *disFilter = [[GPUImageSketchFilter alloc] init];
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:self.inputImage.size];
    [disFilter useNextFrameForImageCapture];
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:self.inputImage];
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(50,50,self.inputImage.size.width ,self.inputImage.size.height);
    [self.view addSubview:imageView];

}
@end
