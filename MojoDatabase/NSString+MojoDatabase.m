//
//  NSString+MojoDatabase.m
//  DHC
//
//  Created by matsuda on 12/04/05.
//  Copyright (c) 2012年 KBMJ. All rights reserved.
//

#import "NSString+MojoDatabase.h"

@implementation NSString (MojoDatabase)

// 文字列中の単語を複数形に変換します
- (NSString *)pluralizeString {
    NSDictionary *plurals  = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"s"       , @"$"                         ,
                              @"s"       , @"s$"                        ,
                              @"$1es"    , @"(ax|test)is$"              ,
                              @"$1i"     , @"(octop|vir)us$"            ,
                              @"$1es"    , @"(alias|status)$"           ,
                              @"$1ses"   , @"(bu)s$"                    ,
                              @"$1oes"   , @"(buffal|tomat)o$"          ,
                              @"$1a"     , @"([ti])um$"                 ,
                              @"ses"     , @"sis$"                      ,
                              @"$1$2ves" , @"(?:([^f])fe|([lr])f)$"     ,
                              @"$1s"     , @"(hive)$"                   ,
                              @"$1ies"   , @"([^aeiouy]|qu)y$"          ,
                              @"$1es"    , @"(x|ch|ss|sh)$"             ,
                              @"$1ices"  , @"(matr|vert|ind)(?:ix|ex)$" ,
                              @"$1ice"   , @"([m|l])ouse$"              ,
                              @"$1en"    , @"^(ox)$"                    ,
                              @"$1zes"   , @"(quiz)$",
                              nil];
    NSArray *keys = [plurals allKeys];

    NSEnumerator *enumerator = [keys objectEnumerator];
    NSString *replaceStr = nil;
    NSRegularExpressionOptions options = 0;

    for(NSString *key in enumerator) {
        NSError *error = nil;
        NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:key options:options error:&error];
        if (error != nil) {
            NSLog(@"%@", error);
        } else {
            NSTextCheckingResult *match = [regexp firstMatchInString:self options:options range:NSMakeRange(0, [self length])];
            if ([match numberOfRanges] > 0) {
                replaceStr = [regexp stringByReplacingMatchesInString:self options:options range:NSMakeRange(0, [self length]) withTemplate:[plurals objectForKey:key]];
            }
        }
        // if (replaceStr != nil && [replaceStr length] > 0) break;
    }
    return replaceStr;
}

@end
