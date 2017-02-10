//
//  LLPasswordView.m
//  LLInstalmentSDK
//
//  Created by zdy on 2017/2/9.
//  Copyright © 2017年 lianlian. All rights reserved.
//

#import "LLPasswordView.h"

@implementation LLPasswordView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.normalBorderColor = [UIColor grayColor];
        self.selectedBorderColor = [UIColor redColor];
        self.font = [UIFont systemFontOfSize:20.0f];
        self.isSecure = NO;
        self.value = @"";
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setValue:(NSString *)value {
    _value = value;
    [self setNeedsDisplay];
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

- (BOOL)becomeFirstResponder {
    return [super becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
}

#pragma mark - UIKeyInput
- (BOOL)hasText {
    return self.value.length > 0;
}

- (void)insertText:(NSString *)text {
    if (self.value.length < self.number) {
        static NSString  * const MONEYNUMBERS = @"0123456789";
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:MONEYNUMBERS] invertedSet];
        NSString*filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [text isEqualToString:filtered];
        
        if(basicTest) {
            self.value = [self.value stringByAppendingString:text];
            
            if ([self.delegate respondsToSelector:@selector(passwordViewDidChange:)]) {
                [self.delegate passwordViewDidChange:self];
            }
            
            if (self.value.length == self.number) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([self.delegate respondsToSelector:@selector(passwordViewCompleteInput:)]) {
                        [self.delegate passwordViewCompleteInput:self];
                    }
                });
            }
        }
    }
}


- (void)deleteBackward {
    if (self.value.length > 0) {
        self.value = [self.value substringToIndex:(self.value.length-1)];
        if ([self.delegate respondsToSelector:@selector(passwordViewDidChange:)]) {
            [self.delegate passwordViewDidChange:self];
        }
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.number <0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat itemW = rect.size.width/self.number;
    CGFloat itemH = rect.size.height;
    
    CGRect *rects = malloc(sizeof(CGRect)*self.number);
    for (int i=0; i<self.number; i++) {
        CGRect rect = CGRectMake(i*itemW , 0, itemW, itemH);
        rects[i] = rect;
    }
    
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, self.normalBorderColor.CGColor);
    CGContextAddRects(context, rects, self.number);
    CGContextStrokePath(context);
    
    free(rects);
    
    for (int i=0; i<self.number; i++) {
        if (i<self.value.length) {
            CGRect rect = CGRectMake(i*itemW, 0, itemW, itemH);
            
            NSString *letter = [self.value substringWithRange:NSMakeRange(i, 1)];
            [letter drawInRect:CGRectInset(rect, (itemW-12)/2, (itemH-22)/2) withAttributes:@{NSFontAttributeName : self.font}];
        }
    }
}

- (void)textFieldDidChanged:(UITextField*)textField {
    self.value = textField.text;
}
@end
