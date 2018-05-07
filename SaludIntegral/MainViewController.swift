//
//  MainViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/8/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }

    @IBOutlet weak var btSuge: UIButton!
    @IBOutlet weak var btActividades: UIButton!
    @IBOutlet weak var btEmergencias: UIButton!
    @IBOutlet weak var btHistorial: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //btSuge.titleLabel?.minimumScaleFactor = 0
        btSuge.titleLabel?.adjustsFontSizeToFitWidth = true
        btSuge.imageView?.contentMode = .scaleAspectFit
        btActividades.titleLabel?.adjustsFontSizeToFitWidth = true
        btActividades.imageView?.contentMode = .scaleAspectFit
        btEmergencias.titleLabel?.adjustsFontSizeToFitWidth = true
        btEmergencias.imageView?.contentMode = .scaleAspectFit
        btHistorial.titleLabel?.adjustsFontSizeToFitWidth = true
        btHistorial.imageView?.contentMode = .scaleAspectFit

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
