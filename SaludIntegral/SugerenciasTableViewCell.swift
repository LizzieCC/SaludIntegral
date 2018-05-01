//
//  SugerenciasTableViewCell.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 3/14/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit

class SugerenciasTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var lbDetalle: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    
    var sugerencia: Sugerencia!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Ver mas
    @IBAction func agregarSugerencia(_ sender: UIButton) {
        
    }
    
    
    
    
    
    
}
