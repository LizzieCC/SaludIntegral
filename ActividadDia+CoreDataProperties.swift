//
//  ActividadDia+CoreDataProperties.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/7/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//
//

import Foundation
import CoreData


extension ActividadDia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActividadDia> {
        return NSFetchRequest<ActividadDia>(entityName: "ActividadDia")
    }

    @NSManaged public var realizado: Bool
    @NSManaged public var fecha: NSDate
    @NSManaged public var hora: NSDate?
    @NSManaged public var actividad: Actividad?
    @NSManaged public var reprogramado: Bool

}
