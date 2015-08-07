//
//  NSString+MojoDatabase.m
//  DHC
//
//  Created by matsuda on 12/04/05.
//  Copyright (c) 2012年 KBMJ. All rights reserved.
//

#import "NSString+MojoDatabase.h"

@implementation NSString (MojoDatabase)

+ (NSArray *)plurals
{
    static dispatch_once_t onceToken;
    static NSArray *_plurals = nil;
    dispatch_once(&onceToken, ^{
        _plurals = [@[
                      @[@"(quiz)$"                   ,   @"$1zes"],
                      @[@"^(ox)$"                    ,   @"$1en"],
                      @[@"([m|l])ouse$"              ,   @"$1ice"],
                      @[@"(matr|vert|ind)(?:ix|ex)$" ,   @"$1ices"],
                      @[@"(x|ch|ss|sh)$"             ,   @"$1es"],
                      @[@"([^aeiouy]|qu)y$"          ,   @"$1ies"],
                      @[@"(hive)$"                   ,   @"$1s"],
                      @[@"(?:([^f])fe|([lr])f)$"     ,   @"$1$2ves"],
                      @[@"sis$"                      ,   @"ses"],
                      @[@"([ti])um$"                 ,   @"$1a"],
                      @[@"(buffal|tomat)o$"          ,   @"$1oes"],
                      @[@"(bu)s$"                    ,   @"$1ses"],
                      @[@"(alias|status)$"           ,   @"$1es"],
                      @[@"(octop|vir)us$"            ,   @"$1i"],
                      @[@"(ax|test)is$"              ,   @"$1es"],
                      @[@"s$"                        ,   @"s"],
                      @[@"$"                         ,   @"s"],
                      ] retain];
    });
    return _plurals;
}

// 文字列中の単語を複数形に変換します
- (NSString *)pluralizeString
{
    NSString *result = [self copy];
    @autoreleasepool {
        NSArray *plurals = [[self class] plurals];
        for (NSArray *rules in plurals) {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:rules[0]
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:nil];
            NSString *s = [regex stringByReplacingMatchesInString:self
                                                          options:NSMatchingReportCompletion
                                                            range:NSMakeRange(0, self.length)
                                                     withTemplate:rules[1]];
            if (![self isEqualToString:s]) {
                [result release];
                result = [s retain];
                break;
            }
        }
    }
    return [result autorelease];
}

@end
