//
//  RWConfig.h
//  MVVM+RAC_Demo
//
//  Created by fdiosone on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//

#ifndef RWConfig_h
#define RWConfig_h

// 懒加载
#define HT_LAZY(object, assignment) (object = object ?: assignment)

// 返回一个字符串
#define stringify   __STRING

// 设置颜色
#define SetColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define SetAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 设置字体
#define HTSetFont(fontName,font)    [UIFont fontWithName:(fontName) size:(font)]

// 获取屏幕宽度，高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MainScreenRect       [UIScreen mainScreen].bounds

#define HT_APPDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)

// debug下打印，release下不打印
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#endif /* RWConfig_h */
