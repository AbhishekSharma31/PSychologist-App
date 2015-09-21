//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Abhishek Sharma on 2/27/15.
//  Copyright (c) 2015 Abhishek. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDatasource
{
    
        var happiness: Int = 25 { // O = very sad, 100 = ecstatatic
        didSet{
            happiness = min(max(happiness,0),100)
            println("happiness = \(happiness)")
            updateUI()
            
        }
        
    }
    
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 5
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            happiness += happinessChange
            gesture.setTranslation(CGPointZero, inView: faceView)
       
        
        default:break
    }
    }


    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
   
private func updateUI()
{
    faceView?.setNeedsDisplay()
    title = "\(happiness)"
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
    
}
