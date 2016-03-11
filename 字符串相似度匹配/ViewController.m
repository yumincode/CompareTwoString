//
//  ViewController.m
//  字符串相似度匹配
//
//  Created by 虞敏 on 16/3/11.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (float) likePercent:(NSString *)testString AndTargetString:(NSString *)target{
    int n = testString.length;
    int m = target.length;
    if (m==0) return n;
    if (n==0) return m;
    //Construct a matrix, need C99 support
    int matrix[n+1][m+1];
    memset(&matrix[0], 0, m+1);
    for(int i=1; i<=n; i++) {
        memset(&matrix[i], 0, m+1);
        matrix[i][0]=i;
    }
    for(int i=1; i<=m; i++) {
        matrix[0][i]=i;
    }
    for(int i=1;i<=n;i++)
    {
        unichar si = [testString characterAtIndex:i-1];
        for(int j=1;j<=m;j++)
        {
            unichar dj = [target characterAtIndex:j-1];
            int cost;
            if(si==dj){
                cost=0;
            }
            else{
                cost=1;
            }
            const int above=matrix[i-1][j]+1;
            const int left=matrix[i][j-1]+1;
            const int diag=matrix[i-1][j-1]+cost;
            matrix[i][j]=MIN(above, MIN(left, diag));
        }
    }
    return 100.0 - 100.0*matrix[n][m]/testString.length;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    float percent=[self likePercent:@"helloworld" AndTargetString:@"helloWorld"];
    NSLog(@"percent=%f",percent);
}


@end
