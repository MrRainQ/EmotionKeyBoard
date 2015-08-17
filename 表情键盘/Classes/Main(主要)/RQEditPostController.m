//
//  RQEditPostController.m
//  diyidan
//
//  Created by sen5labs on 15/2/9.
//  Copyright (c) 2015年 diyidan. All rights reserved.
//

#import "RQEditPostController.h"
#import "RQCommentToolBar.h"
#import "HMEmotionKeyboard.h"
#import "HMEmotionTextView.h"

@interface RQEditPostController ()<UITableViewDataSource,UITableViewDelegate,RQCommentToolBarDelegate,UITextViewDelegate>
@property (nonatomic, strong) NSMutableArray *statusFrames;
@property (nonatomic, weak)   UITableView *tableView;

@property (nonatomic, strong) RQCommentToolBar *toolbar;
@property (nonatomic, strong) HMEmotionKeyboard *keyboard; // emoji
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;


@end

@implementation RQEditPostController

- (HMEmotionKeyboard *)keyboard
{
    if (!_keyboard) {
        self.keyboard = [HMEmotionKeyboard keyboard];
        self.keyboard.width = kScreenWidth;
        self.keyboard.height = 216;
    }
    return _keyboard;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupToolbar];
}

#pragma mark - 添加工具条
- (void)setupToolbar
{
    // 1.创建
    RQCommentToolBar *toolbar = [[RQCommentToolBar alloc] init];
    toolbar.delegate = self;
    toolbar.width = self.view.width;
    toolbar.height = 40;
    self.toolbar = toolbar;
    // 2.显示
    toolbar.y = self.view.height - toolbar.height;
    
    [self.view addSubview:self.toolbar];

    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:HMEmotionDidSelectedNotification object:nil];
    // 监听删除按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:HMEmotionDidDeletedNotification object:nil];
}

#pragma mark - 键盘处理
/** 键盘即将隐藏 */
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.isChangingKeyboard) {
        self.changingKeyboard = NO;
        return;
    }
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

/** 键盘即将弹出 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

#pragma mark -RQCommentToolBar的代理方法
- (void)commentTool:(RQCommentToolBar *)toolbar didClickedButton:(RQCommentToolbarButtonType)buttonType
{
    switch (buttonType) {
        case RQCommentToolbarButtonTypeEmotion: // 选项卡
            [self openKeyboard];
            break;
        case RQCommentToolbarButtonTypeSend:  // 发送
            [self sendWord];
            break;
    }
}

- (void)sendWord
{
    NSLog(@"%@",[self.toolbar.textView realText]);
}

- (void)commentCoverBtnClick
{
    [self openKeyboard];
}

- (void)openKeyboard
{
    self.changingKeyboard = YES;
    
    if (!self.toolbar.textView.inputView) {
        self.toolbar.textView.inputView = self.keyboard;
        self.toolbar.showEmotionButton = NO;
    }else{
        self.toolbar.textView.inputView = nil;
        self.toolbar.showEmotionButton = YES;
    }
    
    [self.toolbar.textView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.toolbar.textView becomeFirstResponder];
    });
}


/** 当表情选中的时候调用
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    HMEmotion *emotion = note.userInfo[HMSelectedEmotion];
    
    [self.toolbar.textView appendEmotion:emotion];
    
    //检测文字长度
    [self textViewDidChange:self.toolbar.textView];
}

/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    // 往回删
    [self.toolbar.textView deleteBackward];
}

- (void)textViewDidChange:(UITextView *)textView{}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
