//
//  main.m
//  BlockPractive
//
//  Created by Yuya Kida on 2015/06/01.
//  Copyright (c) 2015年 Yuya Kida. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Start To Practice block strategy!");
        
       __block int multiplier = 6;
        int (^myBlock)(int) = ^(int num){
            multiplier++;
            return num*multiplier;
        };
        NSLog(@"%d", myBlock(3));
        NSLog(@"%d", myBlock(3));
    }
    return 0;
}
