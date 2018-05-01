//
//  Contacto+CoreDataProperties.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/7/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//
//

import Foundation
import CoreData


extension Contacto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacto> {
        return NSFetchRequest<Contacto>(entityName: "Contacto")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var telefono: String?
    @NSManaged public var tipo: Int32

}
