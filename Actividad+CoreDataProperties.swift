//
//  Actividad+CoreDataProperties.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/7/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//
//

import Foundation
import CoreData


extension Actividad {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Actividad> {
        return NSFetchRequest<Actividad>(entityName: "Actividad")
    }

    @NSManaged public var fechaProgramada: NSDate?
    @NSManaged public var titulo: String
    @NSManaged public var esPeriodico: Bool
    @NSManaged public var alarma: NSDate?
    @NSManaged public var tipoFrecuencia: Int32
    @NSManaged public var frecuenciaSemana: [Bool]?
    @NSManaged public var tieneAlarma: Bool
    @NSManaged public var area: Int32
    
    //@NSManaged public var actividadesDia: [ActividadDia]?
}
