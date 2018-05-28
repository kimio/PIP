//
//  ViewController.swift
//  PIP
//
//  Created by Felipe Kimio Nishikaku on 05/28/2018.
//  Copyright (c) 2018 kimiokun1@gmail.com. All rights reserved.
//

import UIKit
import PIP

class ViewController: UIViewController {
    
    @IBOutlet weak var viewToPip: UIView!
    let pip = PIP()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pipConfiguration = PIPConfiguration(viewToPip: viewToPip)
        pipConfiguration.animateDuration = 0.5
        pip.addPictureInPicture(configuration: pipConfiguration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

