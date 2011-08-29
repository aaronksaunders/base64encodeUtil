/**
 * Copyright (c) 2011 by Clearly Innovative, Inc.
 * and licensed under the Apache Public License (version 2)
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComClearlyinnovativeUtilsModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "Base64Transcoder.h"
#import "TiBlob.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation ComClearlyinnovativeUtilsModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"c8ef6dc3-60d2-41bc-a5a1-84e146b92d0b";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.clearlyinnovative.utils";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

-(NSString*)convertToString:(id)arg
{
	if ([arg isKindOfClass:[NSString class]])
	{
		return arg;
	}
	else if ([arg isKindOfClass:[TiBlob class]])
	{
		return [(TiBlob*)arg text];
	}
	THROW_INVALID_ARG(@"invalid type");
    
    return NULL;
}



#pragma Public APIs
-(TiBlob*)base64encode:(id)args
{
    ENSURE_SINGLE_ARG(args,NSObject);
    
    
    char *data;
    size_t len ;
    
    
    if ([args isKindOfClass:[TiBlob class]]) {
        TiBlob * blob = (TiBlob*)args;
        NSData * xd = [blob data];
        data = (char *)xd.bytes;
        len = xd.length;
        
        
    }
    else{
        
        
        NSString *str = [self convertToString:args];
        
        
        data = (char *)[str UTF8String];
        len = [str length];
    }
    
    
    size_t outsize = EstimateBas64EncodedDataSize(len);
    char *base64Result = malloc(sizeof(char)*outsize);
    size_t theResultLength = outsize;
    
    
    bool result = Base64EncodeData(data, len, base64Result, &theResultLength);
    if (result)
    {
        NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
        free(base64Result);
        return [[[TiBlob alloc] initWithData:theData mimetype:@"application/octet-stream"] autorelease];
    }    
    free(base64Result);
    return nil;
}


@end
