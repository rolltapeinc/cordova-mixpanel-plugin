#import "MixpanelPlugin.h"

@implementation MixpanelPlugin


// MIXPANEL API


-(void)alias:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSArray* arguments = command.arguments;
    NSString* aliasId = [arguments objectAtIndex:0];
    NSString* originalId = [arguments objectAtIndex:1];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else if(aliasId == nil || 0 == [aliasId length])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Alias id missing"];
    }
    else
    {
        [mixpanelInstance createAlias:aliasId forDistinctID:originalId];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)flush:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else
    {
        [mixpanelInstance flush];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)identify:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSArray* arguments = command.arguments;
    NSString* distinctId = [arguments objectAtIndex:0];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else
    {
        if(distinctId == nil || 0 == [distinctId length])
        {
            distinctId = mixpanelInstance.distinctId;
        }
        [mixpanelInstance identify:distinctId];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)init:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    NSArray* arguments = command.arguments;
    NSString* token = [arguments objectAtIndex:0];

    if (token == nil || 0 == [token length])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Token is missing"];
    }
    else
    {
        [Mixpanel sharedInstanceWithToken:token];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)reset:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else
    {
        [mixpanelInstance reset];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)track:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSArray* arguments = command.arguments;
    NSString* eventName = [arguments objectAtIndex:0];
    NSDictionary* eventProperties = [command.arguments objectAtIndex:1];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else if(eventName == nil || 0 == [eventName length])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Event name missing"];
    }
    else
    {
        [mixpanelInstance track:eventName properties:eventProperties];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


// PEOPLE API


-(void)people_identify:(CDVInvokedUrlCommand*)command;
{
    // ios sdk doesnt have separate people identify method
    // just call the normal identify call
    [self identify:command];
}


-(void)people_increment:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSArray* arguments = command.arguments;
    NSDictionary* incrementProperties = [command.arguments objectAtIndex:0];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else if(incrementProperties == nil || 0 == [incrementProperties count])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"missing increment properties object"];
    }
    else
    {
        [mixpanelInstance.people increment:incrementProperties];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)people_set:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSArray* arguments = command.arguments;
    NSDictionary* peopleProperties = [command.arguments objectAtIndex:0];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else if(peopleProperties == nil || 0 == [peopleProperties count])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"missing people properties object"];
    }
    else
    {
        [mixpanelInstance.people set:peopleProperties];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
