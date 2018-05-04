//
//  ProgresoActividadTableViewCell.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/24/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit

class ProgresoActividadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbProgreso: UILabel!
    @IBOutlet weak var lbActividad: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //progressView.transform = progressView.transform.scaledBy(x: 1, y: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
