//
//  main.m
//  NoDsh
//
//  Created by Doug DeJulio on 4/16/14.
//  Copyright (c) 2014 AISB. All rights reserved.
//

#include <stdlib.h>
#include <stdio.h>

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <Knowed/KnowedConsole.h>

int main(int argc, const char * argv[])
{
    JSContext *context;
    KnowedConsole *console;

    __block char *buf = NULL;
    __block size_t bufsiz = 0;
    
    context = [[JSContext alloc] init];
    console = [[KnowedConsole alloc] initWithStdout];
    
    context[@"console"] = console;
    
    context[@"alert"] = ^(NSString *message) {
        printf("» %s\n", [message UTF8String]);
    };
    
    context[@"prompt"] = (NSString *)^(NSString *message) {
        printf("%s « ", [message UTF8String]);
        ssize_t count = getline(&buf, &bufsiz, stdin);
        if (count <1) {
            return @"";
        }
        buf[count-1] = '\0';
        return @(buf);
    };

    printf("> ");
    while (getline(&buf, &bufsiz, stdin)>0) {
        @autoreleasepool {
            JSValue *result = [context evaluateScript: @(buf)];
            printf("%s\n> ", [[result toString] UTF8String]);
        }
    }
        
    return 0;
}

