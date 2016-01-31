//
//  PieChartDocument.m
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "PieChartDocument.h"
#import "PieValue.h"
#import "AppDelegate.h"
#define EMPTY "Empty"

@implementation PieChartDocument

/*
- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return <#nibName#>;
}
*/

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
    }
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    self.noteContent = [[NSString alloc] initWithBytes:[data bytes]
                                                length:[data length]
                                              encoding:NSUTF8StringEncoding];
    NSLog(@"Note contents:%@",self.noteContent);
    PieChart *constructedPieChart=[self modelFromString:self.noteContent];
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    [appDelegate.pieCharts addObject:constructedPieChart];
    
    
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
    }
    return NO;
}

+ (BOOL)autosavesInPlace {
    return YES;
}

-(PieChart*) modelFromString:(NSString *)string{
    PieChart *model=[[PieChart alloc] init];
    
    NSArray *lines = [string componentsSeparatedByString:@"\n"]; // each line, adjust character for line endings
    int lineNo=0;
        //read each line of the string and interpret
    for (NSString *lineWithNewLine in lines){

        NSString *line = [lineWithNewLine stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];

        if(lineNo==0) {
            //first line is title
            model.title=line;
        }else if(lineNo>=2){    //second line is header
            //third line onwards we have pie values
            PieValue *pieValue=[self pieValueFromString:line];//returns nil for last empty line
            
            //pie value can be nil for the last line which is empty,so we ignore that
            if(pieValue!=nil){
                [model addPieValue:pieValue];
            }

        }
        lineNo++;
    }
    return model;
}

-(PieValue*)pieValueFromString:(NSString*)string{
    PieValue *pieValue=[[PieValue alloc] init];
    NSArray *components = [string componentsSeparatedByString:@","];//CSV
    int componentIndex=0;
    for (NSString *component in components){
        //strip the component of the quotes
        NSString* coreValue=[component stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
        switch (componentIndex) {
            case 0:
                pieValue.r=[coreValue floatValue];
                break;
            case 1:
                pieValue.g=[coreValue floatValue];
                break;
            case 2:
                pieValue.b=[coreValue floatValue];
                break;
            case 3:
                pieValue.a=[coreValue floatValue];
                break;
            case 4:
                pieValue.name=coreValue;
                break;
            case 5:
                pieValue.value=[NSNumber numberWithFloat:[coreValue floatValue]];
                break;
            default:
                break;
        }
        componentIndex++;
    }
    return pieValue;
}

@end
