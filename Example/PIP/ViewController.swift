//
//  ViewController.swift
//  PIP
//
//  Created by Felipe Kimio Nishikaku on 05/28/2018.
//  Copyright (c) 2018 kimiokun1@gmail.com. All rights reserved.
//

import UIKit
import PIP

extension UIViewController: PIPDelegate {
    
    public func onFullScreen() {
        print("full screen")
    }
    
    public func onMoveEnded(frame: CGRect) {
        print("moved")
    }
    
    public func onRemove() {
        print("removed")
    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var viewToPip: UIView!
    @IBOutlet weak var removeView: UIView!
    
    var pip: PIP?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pipConfiguration = PIPConfiguration(viewToPip: viewToPip)
        pipConfiguration.animateDuration = 0.5
        pipConfiguration.removeView = removeView
        pip = PIP(configuration: pipConfiguration)
        pip?.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        pip?.updatePipRect(CGRect(x: 0,
                                  y: 0,
                                  width: size.width,
                                  height: size.height))
    }
}
