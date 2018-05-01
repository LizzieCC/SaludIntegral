//
//  HistorialViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/22/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit

class HistorialViewController: UIViewController {

    @IBOutlet weak var btnSaludHist: UIButton!
    @IBOutlet weak var btnMentalHist: UIButton!
    @IBOutlet weak var btnFinanzasHist: UIButton!
    @IBOutlet weak var btnEspiritualHist: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vista = segue.destination as! VerHistorialTableViewController
        if segue.identifier! == "Salud" {
            vista.area = Area.Fisico
        } else if segue.identifier! == "Mental" {
            vista.area = Area.Mental
        } else if segue.identifier! == "Finanzas" {
            vista.area = Area.Financiero
        } else if segue.identifier! == "Espiritual" {
            vista.area = Area.Espiritual
        }
    }

}
