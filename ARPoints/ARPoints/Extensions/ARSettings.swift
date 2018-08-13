//
//  ARSettings.swift
//  ARKit By Example
//
//  Created by Josh Robbins on 17/02/2018.
//  Copyright © 2018 BlackMirrorz. All rights reserved.
//

import Foundation
import UIKit
import ARKit

//----------------------------------------------------
//MARK: VIewController Extensions For Setting Up ARKit
//----------------------------------------------------

extension UIViewController{
  
    /// The Type Of Plane Detection Needed During The ARSession
    ///
    /// - Horizontal: Horizontal Plane Detection
    /// - Vertical: Vertical Plane Detection
    /// - Both: Horizontal & Vertical Plane Detection
    /// - None: No Plane Detection
    enum ARPlaneDetection {
        
        case Horizontal, Vertical, Both, None
    }
    
    /// The Type Of Debug Options Needed During The ARSession
    ///
    /// - FeaturePoints: Show Feature Points
    /// - WorldOrigin: Show The World Origin
    /// - Both: Show Both Feature Points & The World Origin
    /// - **None**: Show None (Development Build)
    enum ARDebugOptions{
        
        case FeaturePoints, WorldOrigin, Both, None
    }
    
    /// The Type Of ARConfiguration Needed
    ///
    /// - ResetTracking: Resets World Tracking
    /// - RemoveAnchors: Removes All Existing Session Anchors
    /// - **ResetAndRemove**: Resets World Tracking & Removes All Existing Anchors
    /// - None: No Congifuration
    enum ARConfigurationOptions{
        
        case ResetTracking, RemoveAnchors, ResetAndRemove, None
        
    }
    
    /// Sets The Type Of Plane Detection Needed During The Session
    ///
    /// - Parameter planeDetection: ARPlaneDetection
    /// - Returns: ARWorldTrackingConfiguration.PlaneDetection
    func planeDetection(_ planeDetection: ARPlaneDetection) -> ARWorldTrackingConfiguration.PlaneDetection{
        
        switch planeDetection {
            
        case .Horizontal:
            return [.horizontal]
        case .Vertical:
            return [.vertical]
        case .Both:
            return [.horizontal, .vertical]
        case .None:
            return []
            
        }
    }
    
    /// Sets The ARSession Debug Options
    ///
    /// - Parameter options: ARDebugOptions
    /// - Returns: SCNDebugOptions
    func debug(_ options: ARDebugOptions) -> SCNDebugOptions{
        
        switch options {
            
        case .FeaturePoints:
            return [SCNDebugOptions.showFeaturePoints]
        case .WorldOrigin:
            return [SCNDebugOptions.showWorldOrigin]
        case .Both:
            return [SCNDebugOptions.showFeaturePoints, SCNDebugOptions.showWorldOrigin]
        case .None:
            return []
        }
    }
    
    /// Sets The ARSession Run Options
    ///
    /// - Parameter configuration: ARConfigurationOptions
    /// - Returns: ARSession.RunOptions
    func runOptions(_ configuration: ARConfigurationOptions) -> ARSession.RunOptions{
        
        switch configuration {
        
        case .ResetTracking:
            return [.resetTracking]
        case .RemoveAnchors:
            return [.removeExistingAnchors]
        case .ResetAndRemove:
            return [.resetTracking, .removeExistingAnchors ]
        case .None:
            return []
        }
    }
}

//------------------------------------------------
//MARK: ARSession Extension To Log Tracking States
//------------------------------------------------

extension ARSession{
    
    /// Returns The Status Of The Current ARSession
    ///
    /// - Returns: String
    func sessionStatus() -> String? {
        
        //1. Get The Current Frame
        guard let frame = self.currentFrame else { return nil }
        
        var status = "Preparing Device.."
        
        //1. Return The Current Tracking State & Lighting Conditions
        switch frame.camera.trackingState {
            
        case .normal:                                                   status = ""
        case .notAvailable:                                             status = "Tracking Unavailable"
        case .limited(.excessiveMotion):                                status = "Please Slow Your Movement"
        case .limited(.insufficientFeatures):                           status = "Try To Point At A Flat Surface"
        case .limited(.initializing):                                   status = "Initializing"
        case .limited(.relocalizing):                                   status = "Relocalizing"
        
        }
    
        guard let lightEstimate = frame.lightEstimate?.ambientIntensity else { return nil }
        
        if lightEstimate < 100 { status = "Lighting Is Too Dark" }
        
        return status
 
    }

}

//--------------------------------------------
//MARK: ARSCNView Extension For Lighting Setup
//--------------------------------------------

extension ARSCNView{
    
    /// Applies Auto Lighting Of The ARSCNView
    func applyLighting() {
        self.autoenablesDefaultLighting = true
        self.automaticallyUpdatesLighting = true
    }
}
