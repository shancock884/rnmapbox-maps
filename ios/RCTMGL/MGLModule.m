//
//  MGLModule.m
//  RCTMGL
//
//  Created by Nick Italiano on 8/23/17.
//  Copyright © 2017 Mapbox Inc. All rights reserved.
//

#import "MGLModule.h"
#import "RCTMGLEventTypes.h"
#import "MGLOfflineModule.h"
#import "CameraMode.h"
#import "RCTMGLSource.h"
@import Mapbox;

@implementation MGLModule

RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (NSDictionary<NSString *, id> *)constantsToExport
{
    // style urls
    NSMutableDictionary *styleURLS = [[NSMutableDictionary alloc] init];
    [styleURLS setObject:[MGLStyle.streetsStyleURL absoluteString] forKey:@"Street"];
    [styleURLS setObject:[MGLStyle.darkStyleURL absoluteString] forKey:@"Dark"];
    [styleURLS setObject:[MGLStyle.lightStyleURL absoluteString] forKey:@"Light"];
    [styleURLS setObject:[MGLStyle.outdoorsStyleURL absoluteString] forKey:@"Outdoors"];
    [styleURLS setObject:[MGLStyle.satelliteStyleURL absoluteString] forKey:@"Satellite"];
    [styleURLS setObject:[MGLStyle.satelliteStreetsStyleURL absoluteString] forKey:@"SatelliteStreet"];
    [styleURLS setObject:[MGLStyle.trafficDayStyleURL absoluteString] forKey:@"TrafficDay"];
    [styleURLS setObject:[MGLStyle.trafficNightStyleURL absoluteString] forKey:@"TrafficNight"];
    
    // event types
    NSMutableDictionary *eventTypes = [[NSMutableDictionary alloc] init];
    [eventTypes setObject:RCT_MAPBOX_EVENT_TAP forKey:@"MapClick"];
    [eventTypes setObject:RCT_MAPBOX_EVENT_LONGPRESS forKey:@"MapLongClick"];
    [eventTypes setObject:RCT_MAPBOX_REGION_WILL_CHANGE_EVENT forKey:@"RegionWillChange"];
    [eventTypes setObject:RCT_MAPBOX_REGION_IS_CHANGING forKey:@"RegionIsChanging"];
    [eventTypes setObject:RCT_MAPBOX_REGION_DID_CHANGE forKey:@"RegionDidChange"];
    [eventTypes setObject:RCT_MAPBOX_WILL_START_LOADING_MAP forKey:@"WillStartLoadingMap"];
    [eventTypes setObject:RCT_MAPBOX_DID_FINISH_LOADING_MAP forKey:@"DidFinishLoadingMap"];
    [eventTypes setObject:RCT_MAPBOX_DID_FAIL_LOADING_MAP forKey:@"DidFailLaodingMap"];
    [eventTypes setObject:RCT_MAPBOX_WILL_START_RENDERING_FRAME forKey:@"WillStartRenderingFrame"];
    [eventTypes setObject:RCT_MAPBOX_DID_FINSIH_RENDERING_FRAME forKey:@"DidFinishRenderingFrame"];
    [eventTypes setObject:RCT_MAPBOX_DID_FINISH_RENDERING_FRAME_FULLY forKey:@"DidFinishRenderingFrameFully"];
    [eventTypes setObject:RCT_MAPBOX_WILL_START_RENDERING_MAP forKey:@"WillStartRenderingMap"];
    [eventTypes setObject:RCT_MAPBOX_DID_FINISH_RENDERING_MAP forKey:@"DidFinishRenderingMap"];
    [eventTypes setObject:RCT_MAPBOX_DID_FINISH_RENDERING_MAP_FULLY forKey:@"DidFinishRenderingMapFully"];
    [eventTypes setObject:RCT_MAPBOX_DID_FINISH_LOADING_STYLE forKey:@"DidFinishLoadingStyle"];
    
    // user tracking modes
    NSMutableDictionary *userTrackingModes = [[NSMutableDictionary alloc] init];
    [userTrackingModes setObject:[NSNumber numberWithInt:MGLUserTrackingModeNone] forKey:@"None"];
    [userTrackingModes setObject:[NSNumber numberWithInt:MGLUserTrackingModeFollow] forKey:@"Follow"];
    [userTrackingModes setObject:[NSNumber numberWithInt:MGLUserTrackingModeFollowWithHeading] forKey:@"FollowWithHeading"];
    [userTrackingModes setObject:[NSNumber numberWithInt:MGLUserTrackingModeFollowWithCourse] forKey:@"FollowWithCourse"];
    
    // camera modes
    NSMutableDictionary *cameraModes = [[NSMutableDictionary alloc] init];
    [cameraModes setObject:[NSNumber numberWithInt:RCT_MAPBOX_CAMERA_MODE_FLIGHT] forKey:@"Flight"];
    [cameraModes setObject:[NSNumber numberWithInt:RCT_MAPBOX_CAMERA_MODE_EASE] forKey:@"Ease"];
    [cameraModes setObject:[NSNumber numberWithInt:RCT_MAPBOX_CAMERA_MODE_NONE] forKey:@"None"];
    
    // style sources
    NSMutableDictionary *styleSourceConsts = [[NSMutableDictionary alloc] init];
    [styleSourceConsts setObject:DEFAULT_SOURCE_ID forKey:@"DefaultSourceID"];

    // interpolation modes
    NSMutableDictionary *interpolationModes = [[NSMutableDictionary alloc] init];
    [interpolationModes setObject:@(MGLInterpolationModeExponential) forKey:@"Exponential"];
    [interpolationModes setObject:@(MGLInterpolationModeCategorical) forKey:@"Categorial"];
    [interpolationModes setObject:@(MGLInterpolationModeInterval) forKey:@"Interval"];
    [interpolationModes setObject:@(MGLInterpolationModeIdentity) forKey:@"Identity"];
    
    // line layer constants
    NSMutableDictionary *lineJoin = [[NSMutableDictionary alloc] init];
    [lineJoin setObject:@(MGLLineJoinBevel) forKey:@"Bevel"];
    [lineJoin setObject:@(MGLLineJoinRound) forKey:@"Round"];
    [lineJoin setObject:@(MGLLineJoinMiter) forKey:@"Miter"];
    
    NSMutableDictionary *lineCap = [[NSMutableDictionary alloc] init];
    [lineCap setObject:@(MGLLineCapButt) forKey:@"Butt"];
    [lineCap setObject:@(MGLLineCapRound) forKey:@"Round"];
    [lineCap setObject:@(MGLLineCapSquare) forKey:@"Square"];
    
    NSMutableDictionary *lineTranslateAnchor = [[NSMutableDictionary alloc] init];
    [lineTranslateAnchor setObject:@(MGLLineTranslationAnchorMap) forKey:@"Map"];
    [lineTranslateAnchor setObject:@(MGLLineTranslationAnchorViewport) forKey:@"Viewport"];
    
    // circle layer constants
    NSMutableDictionary *circlePitchScale = [[NSMutableDictionary alloc] init];
    [circlePitchScale setObject:@(MGLCircleScaleAlignmentMap) forKey:@"Map"];
    [circlePitchScale setObject:@(MGLCircleScaleAlignmentViewport) forKey:@"Viewport"];
    
    NSMutableDictionary *circleTranslateAnchor = [[NSMutableDictionary alloc] init];
    [circleTranslateAnchor setObject:@(MGLCircleTranslationAnchorMap) forKey:@"Map"];
    [circleTranslateAnchor setObject:@(MGLCircleTranslationAnchorViewport) forKey:@"Viewport"];
    
    // fill extrusion layer constants
    NSMutableDictionary *fillExtrusionTranslateAnchor = [[NSMutableDictionary alloc] init];
    [fillExtrusionTranslateAnchor setObject:@(MGLFillExtrusionTranslationAnchorMap) forKey:@"Map"];
    [fillExtrusionTranslateAnchor setObject:@(MGLFillExtrusionTranslationAnchorViewport) forKey:@"Viewport"];
    
    // fill layer constants
    NSMutableDictionary *fillTranslateAnchor = [[NSMutableDictionary alloc] init];
    [fillTranslateAnchor setObject:@(MGLFillTranslationAnchorMap) forKey:@"Map"];
    [fillTranslateAnchor setObject:@(MGLFillTranslationAnchorViewport) forKey:@"Viewport"];
    
    // symbol layer constants
    NSMutableDictionary *iconRotationAlignment = [[NSMutableDictionary alloc] init];
    [iconRotationAlignment setObject:@(MGLIconRotationAlignmentAuto) forKey:@"Auto"];
    [iconRotationAlignment setObject:@(MGLIconRotationAlignmentMap) forKey:@"Map"];
    [iconRotationAlignment setObject:@(MGLIconRotationAlignmentViewport) forKey:@"Viewport"];
    
    NSMutableDictionary *iconTextFit = [[NSMutableDictionary alloc] init];
    [iconTextFit setObject:@(MGLIconTextFitNone) forKey:@"None"];
    [iconTextFit setObject:@(MGLIconTextFitWidth) forKey:@"Width"];
    [iconTextFit setObject:@(MGLIconTextFitHeight) forKey:@"Height"];
    [iconTextFit setObject:@(MGLIconTextFitBoth) forKey:@"Both"];
    
    NSMutableDictionary *iconTranslateAnchor = [[NSMutableDictionary alloc] init];
    [iconTranslateAnchor setObject:@(MGLIconTranslationAnchorMap) forKey:@"Map"];
    [iconTranslateAnchor setObject:@(MGLIconTranslationAnchorViewport) forKey:@"Viewport"];
    
    NSMutableDictionary *symbolPlacement = [[NSMutableDictionary alloc] init];
    [symbolPlacement setObject:@(MGLSymbolPlacementLine) forKey:@"Line"];
    [symbolPlacement setObject:@(MGLSymbolPlacementPoint) forKey:@"Point"];
    
    NSMutableDictionary *textAnchor = [[NSMutableDictionary alloc] init];
    [textAnchor setObject:@(MGLTextAnchorCenter) forKey:@"Center"];
    [textAnchor setObject:@(MGLTextAnchorLeft) forKey:@"Left"];
    [textAnchor setObject:@(MGLTextAnchorRight) forKey:@"Right"];
    [textAnchor setObject:@(MGLTextAnchorTop) forKey:@"Top"];
    [textAnchor setObject:@(MGLTextAnchorBottom) forKey:@"Bottom"];
    [textAnchor setObject:@(MGLTextAnchorTopLeft) forKey:@"TopLeft"];
    [textAnchor setObject:@(MGLTextAnchorTopRight) forKey:@"TopRight"];
    [textAnchor setObject:@(MGLTextAnchorBottomLeft) forKey:@"BottomLeft"];
    [textAnchor setObject:@(MGLTextAnchorBottomRight) forKey:@"BottomRight"];
    
    NSMutableDictionary *textJustify = [[NSMutableDictionary alloc] init];
    [textJustify setObject:@(MGLTextJustificationCenter) forKey:@"Center"];
    [textJustify setObject:@(MGLTextJustificationLeft) forKey:@"Left"];
    [textJustify setObject:@(MGLTextJustificationRight) forKey:@"Right"];
    
    NSMutableDictionary *textPitchAlignment = [[NSMutableDictionary alloc] init];
    [textPitchAlignment setObject:@(MGLTextPitchAlignmentAuto) forKey:@"Auto"];
    [textPitchAlignment setObject:@(MGLTextPitchAlignmentMap) forKey:@"Map"];
    [textPitchAlignment setObject:@(MGLTextPitchAlignmentViewport) forKey:@"Viewport"];
    
    NSMutableDictionary *textRotationAlignment = [[NSMutableDictionary alloc] init];
    [textRotationAlignment setObject:@(MGLTextRotationAlignmentAuto) forKey:@"Auto"];
    [textRotationAlignment setObject:@(MGLTextRotationAlignmentMap) forKey:@"Map"];
    [textRotationAlignment setObject:@(MGLTextRotationAlignmentViewport) forKey:@"Viewport"];
    
    NSMutableDictionary *textTransform = [[NSMutableDictionary alloc] init];
    [textTransform setObject:@(MGLTextTransformNone) forKey:@"None"];
    [textTransform setObject:@(MGLTextTransformLowercase) forKey:@"Lowercase"];
    [textTransform setObject:@(MGLTextTransformUppercase) forKey:@"Uppercase"];
    
    NSMutableDictionary *textTranslateAnchor = [[NSMutableDictionary alloc] init];
    [textTranslateAnchor setObject:@(MGLTextTranslationAnchorMap) forKey:@"Map"];
    [textTranslateAnchor setObject:@(MGLTextTranslationAnchorViewport) forKey:@"Viewport"];
    
    // light constants
    NSMutableDictionary *lightAnchor = [[NSMutableDictionary alloc] init];
    [lightAnchor setObject:@(MGLLightAnchorMap) forKey:@"Map"];
    [lightAnchor setObject:@(MGLLightAnchorViewport) forKey:@"Viewport"];
    
    // offline module callback names
    NSMutableDictionary *offlineModuleCallbackNames = [[NSMutableDictionary alloc] init];
    [offlineModuleCallbackNames setObject:RCT_MAPBOX_OFFLINE_CALLBACK_ERROR forKey:@"Error"];
    [offlineModuleCallbackNames setObject:RCT_MAPBOX_OFFLINE_CALLBACK_PROGRESS forKey:@"Progress"];
    
    NSMutableDictionary *offlinePackDownloadState = [[NSMutableDictionary alloc] init];
    [offlinePackDownloadState setObject:@(MGLOfflinePackStateInactive) forKey:@"Inactive"];
    [offlinePackDownloadState setObject:@(MGLOfflinePackStateActive) forKey:@"Active"];
    [offlinePackDownloadState setObject:@(MGLOfflinePackStateComplete) forKey:@"Complete"];
    
    return @{
         @"StyleURL": styleURLS,
         @"EventTypes": eventTypes,
         @"UserTrackingModes": userTrackingModes,
         @"CameraModes": cameraModes,
         @"StyleSource": styleSourceConsts,
         @"InterpolationMode": interpolationModes,
         @"LineJoin": lineJoin,
         @"LineCap": lineCap,
         @"LineTranslateAnchor": lineTranslateAnchor,
         @"CirclePitchScale": circlePitchScale,
         @"CircleTranslateAnchor": circleTranslateAnchor,
         @"FillExtrusionTranslateAnchor": fillExtrusionTranslateAnchor,
         @"FillTranslateAnchor": fillTranslateAnchor,
         @"IconRotationAlignment": iconRotationAlignment,
         @"IconTextFit": iconTextFit,
         @"IconTranslateAnchor": iconTranslateAnchor,
         @"SymbolPlacement": symbolPlacement,
         @"TextAnchor": textAnchor,
         @"TextJustify": textJustify,
         @"TextPitchAlignment": textPitchAlignment,
         @"TextRotationAlignment": textRotationAlignment,
         @"TextTransform": textTransform,
         @"TextTranslateAnchor": textTranslateAnchor,
         @"LightAnchor": lightAnchor,
         @"OfflineCallbackName": offlineModuleCallbackNames,
         @"OfflinePackDownloadState": offlinePackDownloadState
    };
}

RCT_EXPORT_METHOD(setAccessToken:(NSString *)accessToken)
{
    [MGLAccountManager setAccessToken:accessToken];
}

RCT_EXPORT_METHOD(getAccessToken:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *accessToken = MGLAccountManager.accessToken;
    
    if (accessToken != nil) {
        resolve(accessToken);
        return;
    }
    
    reject(@"missing_access_token", @"No access token has been set", nil);
}

@end