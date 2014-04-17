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

    char *buf = NULL;
    size_t bufsiz = 0;
    
    context = [[JSContext alloc] init];
    console = [[KnowedConsole alloc] initWithStdout];
    
    context[@"console"] = console;

    printf("> ");
    while (getline(&buf, &bufsiz, stdin)>0) {
        @autoreleasepool {
            NSString *thisLine = [NSString stringWithUTF8String: buf];
            JSValue *result = [context evaluateScript: thisLine];
            printf("%s\n> ", [[result toString] UTF8String]);
        }
    }
        
    return 0;
}

