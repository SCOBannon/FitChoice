//
//  CustomSegues.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 3/14/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class SegueFromRight: UIStoryboardSegue {
    
    override func perform() {
        // Declare the INITAL view and the DESTINATION view
        // This will break and be nil if you don't have a second view controller for your DESTINATION view
        let initialView = self.source.view as UIView!
        let destinationView = self.destination.view as UIView!
        
        // Specify the screen HEIGHT and WIDTH
        let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth = UIScreen.main.bounds.size.width
        
        // Specify the INITIAL PLACEMENT of the DESTINATION view
        initialView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        destinationView?.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        // Access the app's key window and add the DESTINATION view ABOVE the INITAL view
        let appWindow = UIApplication.shared.keyWindow
        appWindow?.insertSubview(destinationView!, aboveSubview: initialView!)
        
        // Animate the segue's transition
        UIView.animate(withDuration: 0.4, animations: {
            // Right/Left
            initialView?.frame = (initialView?.frame.offsetBy(dx: -screenWidth, dy: 0))!
            destinationView?.frame = (destinationView?.frame.offsetBy(dx: -screenWidth, dy: 0))!
        }) { (Bool) in
            self.source.present(self.destination, animated: false, completion: nil)
        }
        
    }
    
}


class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        // Declare the INITAL view and the DESTINATION view
        // This will break and be nil if you don't have a second view controller for your DESTINATION view
        let initialView = self.source.view as UIView!
        let destinationView = self.destination.view as UIView!
        
        // Specify the screen HEIGHT and WIDTH
        let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth = UIScreen.main.bounds.size.width
        
        // Specify the INITIAL PLACEMENT of the DESTINATION view
        initialView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        destinationView?.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        // Access the app's key window and add the DESTINATION view ABOVE the INITAL view
        let appWindow = UIApplication.shared.keyWindow
        appWindow?.insertSubview(destinationView!, aboveSubview: initialView!)
        
        // Animate the segue's transition
        UIView.animate(withDuration: 0.4, animations: {
            // Left/Right
            initialView?.frame = (initialView?.frame.offsetBy(dx: screenWidth, dy: 0))!
            destinationView?.frame = (destinationView?.frame.offsetBy(dx: screenWidth, dy: 0))!
        }) { (Bool) in
            self.source.present(self.destination, animated: false, completion: nil)
        }
    }
}





class UnwindSegueFromRight: UIStoryboardSegue {
    //    override func perform() {
    //        // Assign the source and destination views to local variables.
    //        let initialView = self.source.view as UIView!
    //        let destinationView = self.destination.view as UIView!
    //
    //        let screenWidth = UIScreen.main.bounds.size.width
    //
    //        let window = UIApplication.shared.keyWindow
    //        window?.insertSubview(initialView!, aboveSubview: destinationView!)
    //
    //        // Animate the transition.
    //        UIView.animate(withDuration: 0.4, animations: {
    //
    //            initialView?.frame = (initialView?.frame.offsetBy(dx: screenWidth, dy: 0))!
    //            destinationView?.frame = (destinationView?.frame.offsetBy(dx: screenWidth, dy: 0))!
    //
    //        }) { (Bool) in
    //
    //            self.source.dismiss(animated: false, completion: nil)
    //        }
    //    }
    
    override func perform() {
        // Declare the INITAL view and the DESTINATION view
        // This will break and be nil if you don't have a second view controller for your DESTINATION view
        let initialView = self.source.view as UIView!
        let destinationView = self.destination.view as UIView!
        
        // Specify the screen HEIGHT and WIDTH
        let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth = UIScreen.main.bounds.size.width
        
        // Specify the INITIAL PLACEMENT of the DESTINATION view
        initialView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        destinationView?.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        // Access the app's key window and add the DESTINATION view ABOVE the INITAL view
        let appWindow = UIApplication.shared.keyWindow
        appWindow?.insertSubview(destinationView!, aboveSubview: initialView!)
        
        // Animate the segue's transition
        UIView.animate(withDuration: 0.4, animations: {
            // Left/Right
            initialView?.frame = (initialView?.frame.offsetBy(dx: screenWidth, dy: 0))!
            destinationView?.transform = (destinationView?.transform.translatedBy(x: screenWidth, y: 0))!
            //destinationView?.frame = (destinationView?.frame.offsetBy(dx: screenWidth, dy: 0))!
        }) { (complete: Bool) in
            self.source.dismiss(animated: false, completion: nil)
        }
    }
    
}

