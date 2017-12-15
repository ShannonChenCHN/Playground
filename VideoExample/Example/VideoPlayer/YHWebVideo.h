//
//  YHWebVideo.h
//  Example
//
//  Created by ShannonChen on 2017/12/12.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#ifndef YHWebVideo_h
#define YHWebVideo_h

#ifndef YHNonullBlockCallback
#define YHNonullBlockCallback(__BLOCK_NAME__, ...)   \
if (__BLOCK_NAME__) {\
    __BLOCK_NAME__(__VA_ARGS__);\
}
#endif



#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}

#endif /* YHWebVideo_h */
