//
//  VerHistorialTableViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/22/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData

class ProgresoActividad {
    init(titulo: String, porcentaje: Float, hechos: Int, todos: Int) {
        self.titulo = titulo
        self.porcentaje = porcentaje
        self.hechos = hechos
        self.todos = todos
    }
    
    var titulo: String!
    var porcentaje: Float!
    var todos: Int!
    var hechos: Int!
}

class VerHistorialTableViewController: UITableViewController {
    
    
    var actividades: [ProgresoActividad] = []
    var area: Area!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if area == Area.Fisico {
            title = "Fisico"
        } else if area == Area.Mental {
            title = "Mental"
        } else if area == Area.Financiero {
            title = "Finanzas"
        } else if area == Area.Espiritual {
            title = "Espiritual"
        }
        obtenerActividades()
        
    }
    
    func obtenerActividades() {
        do {
            let date = Date()
            let fetchActividad = NSFetchRequest<NSFetchRequestResult>(entityName: "Actividad")
            fetchActividad.predicate = NSPredicate(format: "area==\(Int32(area.rawValue)) && tipoFrecuencia==\(TipoFrecuencia.Semanal.rawValue)")
            let actividadesDeArea = try AppDelegate.context.fetch(fetchActividad) as! [Actividad]
            for actividadArea in actividadesDeArea {
                let fetchActividadDia = NSFetchRequest<NSFetchRequestResult>(entityName: "ActividadDia")
                fetchActividadDia.predicate = NSPredicate(format: "actividad.titulo == %@", actividadArea.titulo)
                let actividadesDia = try AppDelegate.context.fetch(fetchActividadDia) as! [ActividadDia]
                var contador: Float = 0
                var suma: Float = 0
                for actividadDia in actividadesDia {
                    if actividadDia.realizado {
                        suma += 1
                    }
                    contador += 1
                }
                if contador > 0 {
                    let porcentaje = suma/contador
                    actividades.append(ProgresoActividad(titulo: actividadArea.titulo, porcentaje: porcentaje, hechos: Int(suma), todos: Int(contador)))
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actividades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProgresoActividadTableViewCell
        cell.progressView.progress = actividades[indexPath.row].porcentaje
        //cell.lbActividad.text = actividades[indexPath.row].titulo
        //let roundPercentage = (actividades[indexPath.row].porcentaje!*100).rounded()
        let roundPercentage = "\(actividades[indexPath.row].hechos!) de \(actividades[indexPath.row].todos!)"
        cell.lbActividad.text = actividades[indexPath.row].titulo
        cell.lbProgreso.text = "\t \(roundPercentage) actividades realizadas"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
