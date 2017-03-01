//
//  WBStatusLayout.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/5.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "WBStatusLayout.h"
#import "WBStatusTool.h"

/**
 微博的文本中，某些嵌入的图片需要从网上下载，这里简单做个封装
 */
@interface WBTextImageViewAttachment : YYTextAttachment

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, assign) CGSize size;

@end

@implementation WBTextImageViewAttachment {
    UIImageView *_imageView;  // 私有变量
}

/// 重写属性content的setter方法
- (void)setContent:(id)content {
    if ([content isKindOfClass:[UIImageView class]]) {
        _imageView = content;
    }
}

/// 重写属性content的getter方法
- (id)content {
#warning UIImageView 只能在主线程访问 
#warning 按ibireme博客中所说的，“thread_t 和 NSThread 是一一对应的，我们可以通过 pthread_main_thread_np() 或 [NSThread mainThread] 来获取主线程。”
    if (pthread_main_np() == 0) return nil;
    if (_imageView) return _imageView;
    
    /// 第一次获取时 (应该是在文本渲染完成，需要添加附件视图时)，初始化图片视图，并下载图片
    /// 这里改成 YYAnimatedImageView 就能支持 GIF/APNG/WebP 动画了
    _imageView = [UIImageView new];
    _imageView.size = _size;
    [_imageView setImageWithURL:_imageURL placeholder:nil];
    return _imageView;
}
@end


/**
 微博cell的layput
 */
@implementation WBStatusLayout

- (instancetype)initWithStatus:(WBStatus *)status style:(WBLayoutStyle)style {
    if (!status || !status.user) return nil;
    
    self = [super init];
    if (self) {
        _status = status;
        _style = style;
        [self layout];
    }
    
    return self;
}

- (void)layout {
    [self p_layout];
}

- (void)updateDate {
    [self p_layoutSource];
}

#warning 私有方法名统一加p_前缀
- (void)p_layout {
    
    // 1.数据初始化
    self.topSpacingHeight = kWBCellTopMargin;     // cell 顶部灰色留白
    self.titleHeight = 0;                   // 顶部标题栏高度
    self.profileHeight = 0;                 // 个人信息高度
    self.textHeight = 0;                    // 原创文字内容高度
    self.retweetHeight = 0;                 // 转发区域高度
    self.retweetTextHeight = 0;             // 转发中文字内容高度
    self.retweetPicHeight = 0;              // 转发中图片高度
    self.retweetCardHeight = 0;             // 转发中卡片高度
    self.picHeight = 0;                     // 原创图片高度（如果有图片就没有转发内容，反之亦然）
    self.cardHeight = 0;                    // 原创中卡片高度
    self.tagHeight = 0;
    self.toolbarHeight = kWBCellToolbarHeight;          // cell 底部工具条高度
    self.bottomSpacingHeight = kWBCellToolbarBottomMargin;    // cell 底部灰色留白
    
    self.cellHeight = 0;
    
    // 2.文本排版，计算布局
    [self p_layoutTopTitle];  // 2.1 顶部标题栏
    [self p_layoutProfile];   // 2.2 个人信息
    [self p_layoutRetweet];   // 转发内容
    if (_retweetHeight == 0) {
        [self p_layoutPics];        // 如果没有转发内容，那就计算原创配图布局
        if (_picHeight == 0) {
            [self p_layoutCard];    // 如果原创图片也没有，那就计算卡片布局
        }
    }
    [self p_layoutText];    // 原创文字内容
    [self p_layoutTag];     // 底部标签
    [self p_layoutToolbar]; // 工具条
    
    // 3.计算总高度
    self.cellHeight += _topSpacingHeight;
    self.cellHeight += _titleHeight;
    self.cellHeight += _profileHeight;
    self.cellHeight += _textHeight;
    if (_retweetHeight > 0) {              // 转发内容和原创配图、卡片三者只有一个显示
        self.cellHeight += _retweetHeight;
    } else if (_picHeight > 0) {
        self.cellHeight += _picHeight;
    } else if (_cardHeight > 0) {
        self.cellHeight += _cardHeight;
    }
    
    if (_tagHeight > 0) {
        self.cellHeight += _tagHeight;
    } else {
        if (_picHeight > 0 || _cardHeight > 0) { // 如果有原创图片或者卡片，就要加上下方的内边距
            self.cellHeight += kWBCellPadding;
        }
    }
    self.cellHeight += _toolbarHeight;
    self.cellHeight += _bottomSpacingHeight;

}

// 1. 顶部标题栏
- (void)p_layoutTopTitle {
    // 初始设置
    _titleHeight = 0;
    _titleTextLayout = nil;
    
    // 获取title数据
    WBStatusTitle *titleModel = _status.titleModel;
    if (titleModel.text.length == 0) return;
    
    // 处理显示内容
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:titleModel.text];
    if (titleModel.iconURL) { // 如果有icon，
        NSAttributedString *icon = [self p_attachmentWithFontSize:kWBCellTitlebarFontSize imageURL:titleModel.iconURL shrink:NO];
        if (icon) {
            [text insertAttributedString:icon atIndex:0];  // icon放在最前面
        }
    }
    text.color = kWBCellToolbarTitleColor; // 字体颜色
    text.font = [UIFont systemFontOfSize:kWBCellTitlebarFontSize]; // 字体大小
    
    // 创建容器
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 100, kWBCellTitleHeight)];
    
    // 计算layout
    _titleTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    
    // title高度
    _titleHeight = kWBCellTitleHeight;
}

// 2. 个人信息
- (void)p_layoutProfile {
    [self p_layoutName];
    [self p_layoutSource];
    self.profileHeight = kWBCellProfileHeight;
}

// 2.1 昵称
- (void)p_layoutName {
    // 获取昵称信息
    WBUser *user = _status.user;
    NSString *nameStr = nil;
    if (user.remark.length) {
        nameStr = user.remark;
    } else if (user.screenName.length) {
        nameStr = user.screenName;
    } else {
        nameStr = user.name;
    }
    if (nameStr.length == 0) {
        _nameTextLayout = nil;
        return;
    }
    
    // 创建NSMutableAttributedString
    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc] initWithString:nameStr];
    
    // 昵称后面的徽章
    if (user.userVerifyType == WBUserVerifyTypeOrganization) {     // 蓝V
        UIImage *blueVImage = [WBStatusTool imageNamed:@"avatar_enterprise_vip"];
        NSAttributedString *blueVText = [self p_attachmentWithFontSize:kWBCellNameFontSize image:blueVImage shrink:NO];
        [nameText appendString:@" "];  // 加空格，留间距
        [nameText appendAttributedString:blueVText];
    }
    
    if (user.mbrank > 0) {                  // VIP皇冠
        UIImage *yelllowVImage = [WBStatusTool imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        if (!yelllowVImage) {
            yelllowVImage = [WBStatusTool imageNamed:@"common_icon_membership"];
        }
        NSAttributedString *vipText = [self p_attachmentWithFontSize:kWBCellNameFontSize image:yelllowVImage shrink:NO];
        [nameText appendString:@" "];
        [nameText appendAttributedString:vipText];
    }
    
    nameText.font = [UIFont systemFontOfSize:kWBCellNameFontSize];
    nameText.color = user.mbrank > 0 ? kWBCellNameOrangeColor : kWBCellNameNormalColor;
    nameText.lineBreakMode = NSLineBreakByCharWrapping;
    
    // 创建容器
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kWBCellNameWidth, 9999)];
    container.maximumNumberOfRows = 1;
    _nameTextLayout = [YYTextLayout layoutWithContainer:container text:nameText];
}

// 时间和来源
- (void)p_layoutSource {
    NSMutableAttributedString *sourceText = [NSMutableAttributedString new];
    NSString *createTime = [WBStatusTool stringWithTimelineDate:_status.createdAt];
    
    // 时间
    if (createTime.length) {
        NSMutableAttributedString *timeText = [[NSMutableAttributedString alloc] initWithString:createTime];
        [timeText appendString:@"  "];
        timeText.font = [UIFont systemFontOfSize:kWBCellSourceFontSize];
        timeText.color = kWBCellTimeNormalColor;
        [sourceText appendAttributedString:timeText];
    }
    
    // 来自 XXX
    if (_status.source.length) {
        // <a href="sinaweibo://customweibosource" rel="nofollow">iPhone 5siPhone 5s</a>
        static NSRegularExpression *hrefRegex, *textRegex;  // 正则表达式
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            hrefRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=href=\").+(?=\" )" options:kNilOptions error:NULL];  // 截取href=
            textRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=>).+(?=<)" options:kNilOptions error:NULL];
        });
        NSTextCheckingResult *hrefResult, *textResult;
        NSString *href = nil, *text = nil;
        hrefResult = [hrefRegex firstMatchInString:_status.source options:kNilOptions range:NSMakeRange(0, _status.source.length)];
        textResult = [textRegex firstMatchInString:_status.source options:kNilOptions range:NSMakeRange(0, _status.source.length)];
        if (hrefResult && textResult && hrefResult.range.location != NSNotFound && textResult.range.location != NSNotFound) {
            href = [_status.source substringWithRange:hrefResult.range];
            text = [_status.source substringWithRange:textResult.range];
        }
        if (href.length && text.length) {
            NSMutableAttributedString *from = [NSMutableAttributedString new];
            [from appendString:[NSString stringWithFormat:@"来自 %@", text]];
            from.font = [UIFont systemFontOfSize:kWBCellSourceFontSize];
            from.color = kWBCellTimeNormalColor;
            if (_status.sourceAllowClick > 0) {
                NSRange range = NSMakeRange(3, text.length);
                [from setColor:kWBCellTextHighlightColor range:range];
                YYTextBackedString *backed = [YYTextBackedString stringWithString:href];
                [from setTextBackedString:backed range:range];
                
                YYTextBorder *border = [YYTextBorder new];
                border.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
                border.fillColor = kWBCellTextHighlightBackgroundColor;
                border.cornerRadius = 3;
                YYTextHighlight *highlight = [YYTextHighlight new];
                if (href) highlight.userInfo = @{kWBLinkHrefName : href};
                [highlight setBackgroundBorder:border];
                [from setTextHighlight:highlight range:range];
            }
            
            [sourceText appendAttributedString:from];
        }
    }
    
    if (sourceText.length == 0) {
        _sourceTextLayout = nil;
    } else {
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kWBCellNameWidth, 9999)];
        container.maximumNumberOfRows = 1;
        _sourceTextLayout = [YYTextLayout layoutWithContainer:container text:sourceText];
    }
}

// 转发内容
- (void)p_layoutRetweet {
    
}

// 图片
- (void)p_layoutPics {
    
}

// 卡片
- (void)p_layoutCard {
    
}

// 原创文字内容
- (void)p_layoutText {
    
}

// 底部标签
- (void)p_layoutTag {
    
}

// 工具条
- (void)p_layoutToolbar {
    
}

- (NSAttributedString *)p_attachmentWithFontSize:(CGFloat)fontSize image:(UIImage *)image shrink:(BOOL)shrink {
    
//    CGFloat ascent = YYEmojiGetAscentWithFontSize(fontSize);
//    CGFloat descent = YYEmojiGetDescentWithFontSize(fontSize);
//    CGRect bounding = YYEmojiGetGlyphBoundingRectWithFontSize(fontSize);
    
    // Heiti SC 字体。。
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    
    // 自定义CTRun排版属性的回调方法
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;
    
    // 图片
    YYTextAttachment *attachment = [YYTextAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.content = image;
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        attachment.contentInsets = contentInsets;
    }
    
    // 创建NSMutableAttributedString对象
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}


// 富文本中的图片链接的处理
- (NSAttributedString *)p_attachmentWithFontSize:(CGFloat)fontSize imageURL:(NSString *)imageURL shrink:(BOOL)shrink {
    /*
     微博 URL 嵌入的图片，比临近的字体要小一圈。。
     这里模拟一下 Heiti SC 字体，然后把图片缩小一下。
     */
    // 排版相关 http://allenzerg001.github.io/AllenChiangBlog/2014/05/28/core-text/
    CGFloat ascent = fontSize * 0.86;  // 向上高度
    CGFloat descent = fontSize * 0.14; // 向下高度
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    CGSize size = CGSizeMake(fontSize, fontSize);
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);   // floor函数：向下取整; ceil函数：向上取整
        size = CGSizeMake(fontSize - fontSize * scale * 2, fontSize - fontSize * scale * 2);
        size = CGSizePixelRound(size);  // round函数：四舍五入; fabs函数：求浮点数x的绝对值
    }
    
    // 自定义CTRun排版属性的回调方法
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;

    // 图片
    WBTextImageViewAttachment *attachment = [WBTextImageViewAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.size = size;
    attachment.imageURL = [WBStatusTool defaultURLForImageURL:imageURL];

    // 创建NSMutableAttributedString对象
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate); // 要及时释放创建的CTRunDelegateRef类型数据
    
    return atr;
}

@end
