//
//  FrecuenciaSemana.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 3/10/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit

protocol Frecuencia {
    
}

class FrecuenciaSemana: Frecuencia, Codable {
    var tieneLunes: Bool!
    var tieneMartes: Bool!
    var tieneMiercoles: Bool!
    var tieneJueves: Bool!
    var tieneViernes: Bool!
    var tieneSabado: Bool!
    var tieneDomingo: Bool!
    
    init() {
        tieneLunes = true;
        tieneMartes = true;
        tieneMiercoles = true;
        tieneJueves = true;
        tieneViernes = true;
        tieneSabado = true;
        tieneDomingo = true;
    }
}
