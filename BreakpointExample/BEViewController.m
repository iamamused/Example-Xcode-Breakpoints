//
//  BEViewController.m
//  BreakpointExample
//
//  Created by Jeffrey Sambells on 1/10/2014.
//  Copyright (c) 2014 Jeffrey Sambells. All rights reserved.
//

#import "BEViewController.h"

@interface BEViewController ()

@end

@implementation BEViewController

- (IBAction)simpleBreakpointAction:(id)sender
{
    NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
    NSLog(@"<- This simple breakpoint will stop until you continue execution or step over it");
    NSLog(@"<- This simple breakpoint will stop until you continue execution or step over it");
}

- (IBAction)conditionalBreakpointAction:(id)sender
{
    NSLog(@"Demo: Simple Breakpoint (%s)" , __PRETTY_FUNCTION__ );
    BOOL stop = YES;
    NSLog(@"Stop was set to: %@", stop ? @"YES" : @"NO");
    // <- This conditional breakpoint will only work if stop==YES (change it to see)
    
}

- (IBAction)ignoredBreakpointAction:(id)sender
{
    NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
    int i = 0;
    while (++i <= 6) {
        NSLog(@"i = %d", i);
        // <- This breakpoint is ignored 3 times before stopping
    }
}

- (IBAction)logMessageAndContinueBreakpointAction:(id)sender
{
    NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
    // A new message will be in you debug log
}

- (IBAction)logMessageWithValuesAndContinueBreakpointAction:(id)sender
{
    NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
    // A new message will be in you debug log
}

- (IBAction)multipleActionBreakpointAction:(id)sender
{
    NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
    // A new message will be in you debug log
}


- (IBAction)exceptionBreakpointAction:(id)sender
{
    @try {
        // The Breakpoint Navigation has an Exception Breakpoint which will stop here.
        @throw [NSException exceptionWithName:@"Example" reason:@"Testing Breakpoints" userInfo:nil];
    } @catch (NSException *e) {
        // Nothing since this is an example.
    }
}

- (IBAction)symbolicBreakpointAction:(id)sender
{
    // The symbolic breakpoint will stop at the beginning of this method
    // There's also a symbolic breakpoint for
    NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
    
    // This is bad. don't send syncronous requests on teh main thread
    // as it will block the UI.
    // The conditional symbolic breakpoint will stop here.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://jeffreysambells.com"]];
    NSURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSLog(@"Main Thread Request Complete");
    
    
    // This is better, running in a different queue.
    // The conditional symbolic breakpoint will not stop here.
    dispatch_async(dispatch_queue_create("Non Main Queue",NULL), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://jeffreysambells.com"]];
        NSURLResponse *response;
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        NSLog(@"Non Main Thread Request Complete");
    });
    
    
}


@end
