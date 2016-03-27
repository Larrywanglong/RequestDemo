//
//  ViewController.m
//  RequestDemo
//
//  Created by 王龙 on 16/3/27.
//  Copyright © 2016年 Larry（Lawrence）. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
{
    UIImageView *myView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    /*  下载步骤
     1、URL
     2、request
     3、session
     4、下载任务 -> 挂上代理 -> 下载的内容在代理方法中得到
     5、开启任务
     
     */
    
//    1、URL
    NSURL *url1 = [NSURL URLWithString:@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1206/18/c0/12043463_1339987116999.jpg"];
//    2、request
    NSURLRequest *requ = [NSURLRequest requestWithURL:url1];
//    3、session对象
    NSURLSession *session1 = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    
//    4、下载任务
    NSURLSessionDownloadTask *download = [session1 downloadTaskWithRequest:requ];
    
//    5、开启任务
    [download resume];
    
    
    
//    初始化图片视图来显示请求下来的图片  注意需要等待一会才可以请求下来
    myView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    myView.backgroundColor = [UIColor cyanColor];
    myView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:myView];
    
    
    
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    //    NSFileManager 用于文件操作的类
    //    创建文件操作的对象 -> 单例 -> defaultManager
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
//     移动URL路径的方法
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil] ;
//    输出路径  鼠标点击桌面后 commend+shift+G把这个路径拷贝过去可以查看下载下来的图片
    NSLog(@"%@",path);
    myView.image = [UIImage imageWithContentsOfFile:path];
    
    //    NSLog(@"%@",location);
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
