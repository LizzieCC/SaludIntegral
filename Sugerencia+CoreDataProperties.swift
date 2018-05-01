//
//  Sugerencia+CoreDataProperties.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/7/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//
//

import Foundation
import CoreData


extension Sugerencia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sugerencia> {
        return NSFetchRequest<Sugerencia>(entityName: "Sugerencia")
    }

    @NSManaged public var titulo: String?
    @NSManaged public var descripcion: String?
    @NSManaged public var video: String?
    @NSManaged public var imagen: String?
    @NSManaged public var area: Int32
    @NSManaged public var prioridad: Int32
    @NSManaged public var frecuenciaSemana: [Bool]?
    @NSManaged public var tipoFrecuencia: Int32
}
