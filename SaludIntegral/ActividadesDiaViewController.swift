//
//  ActividadesDiaViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/2/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

class ActividadesDiaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tablaActividades: UITableView!
    @IBOutlet weak var lbDia: UILabel!
    
    var actividadesHoy: [Actividad] = []
    var actividadesRealizadas: [ActividadDia] = []
    var diaSeleccionado: Date = Date()
    var actividadSeleccionado: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerDatosActividades()
        actualizarDia()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        obtenerDatosActividades()
        actualizarDia()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let reprogramarAction = UITableViewRowAction(style: .normal, title: "Reprogramar") { action, index in
            
        }
        reprogramarAction.backgroundColor = .orange
        return [reprogramarAction]
    }
    
    func obtenerActividadDia(actividad: Actividad) {
        do {
            var calendar = Calendar.current
            calendar.timeZone = NSTimeZone.local
            let dateFrom = calendar.startOfDay(for: diaSeleccionado)
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute],from: dateFrom)
            components.day! += 1
            let dateTo = calendar.date(from: components)!
            
            let fetchActividadDia = NSFetchRequest<NSFetchRequestResult>(entityName: "ActividadDia")
            fetchActividadDia.predicate = NSPredicate(format: "(%@ <= fecha) AND (fecha < %@) AND actividad.titulo == %@", argumentArray: [dateFrom, dateTo, actividad.titulo])
            let actividadDia = try AppDelegate.context.fetch(fetchActividadDia) as! [ActividadDia]
            print(actividadDia)
            if actividadDia.count > 0 {
                actividadesRealizadas.append(actividadDia[0])
            } else {
                let nuevo = NSEntityDescription.insertNewObject(forEntityName: "ActividadDia", into: AppDelegate.context) as! ActividadDia
                nuevo.fecha = diaSeleccionado as NSDate
                nuevo.actividad = actividad
                actividadesRealizadas.append(nuevo)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func obtenerDatosActividades() {
        actividadesHoy.removeAll()
        actividadesRealizadas.removeAll()
        
        let fetchActividades = NSFetchRequest<NSFetchRequestResult>(entityName: "Actividad")
        fetchActividades.predicate = NSPredicate(format: "tipoFrecuencia == \(TipoFrecuencia.Semanal.rawValue)")
        do {
            let actividades = try AppDelegate.context.fetch(fetchActividades) as! [Actividad]
            for actividad in actividades {
                if(actividad.frecuenciaSemana!  [diaSeleccionado.dayNumberOfWeek()-1]) {
                    actividadesHoy.append(actividad)
                    obtenerActividadDia(actividad: actividad)
                }
            }
        } catch {
            print("Error: \(error)")
        }
        /*let fetchActividadesDia = NSFetchRequest<NSFetchRequestResult>(entityName: "ActividadDia")
        fetchActividadesDia.predicate = NSPredicate(format: "(%@ <= fecha) AND (fecha < %@) AND actividad.tipoFrecuencia == %@ AND reprogramado == false", argumentArray: [diaSeleccionado.yesterday, diaSeleccionado.tomorrow, TipoFrecuencia.Semanal.rawValue])
        do {
            var actividadesDia = try context.fetch(fetchActividadesDia) as! [ActividadDia]
            for actividadDia in actividadesDia {
                actividadesHoy.append(actividadDia.actividad!)
                actividadesDia.append(actividadDia)
            }
        } catch {
            print("Error: \(error)")
        }*/
        
        //let fetchActividades = NSFetchRequest<NSFetchRequestResult>(entityName: "Actividad")
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateFrom = calendar.startOfDay(for: diaSeleccionado)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute],from: dateFrom)
        components.day! += 1
        let dateTo = calendar.date(from: components)!
        fetchActividades.predicate = NSPredicate(format: "tipoFrecuencia == \(TipoFrecuencia.Uno.rawValue) AND (%@ <= fechaProgramada) AND (fechaProgramada < %@)", argumentArray: [dateFrom, dateTo])
        do {
            let actividades = try AppDelegate.context.fetch(fetchActividades) as! [Actividad]
            for actividad in actividades {
                actividadesHoy.append(actividad)
                obtenerActividadDia(actividad: actividad)
            }
        } catch {
            print("Error: \(error)")
        }
        
        tablaActividades.reloadData()
    }
    
    @IBAction func anteriorDia(_ sender: UIButton) {
        diaSeleccionado = diaSeleccionado.yesterday
        actualizarDia()
        obtenerDatosActividades()
    }
    
    
    @IBAction func siguienteDia(_ sender: UIButton) {
        diaSeleccionado = diaSeleccionado.tomorrow
        actualizarDia()
        obtenerDatosActividades()
    }
    
    func actualizarDia() {
        lbDia.text = String(describing: diaSeleccionado.dayOfWeek()!) + ", " +
        (diaSeleccionado.toDateString()!)
    }
    
    func actualizarActividades() {
        tablaActividades.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaActividades.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let actividad = actividadesHoy [indexPath.row]
        cell.textLabel?.text = actividad.titulo
        setCellAccesory(cell: cell, filled: actividadesRealizadas[indexPath.row].realizado)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actividadesHoy.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        actividadSeleccionado = indexPath.row
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actividadesRealizadas[indexPath.row].realizado = !actividadesRealizadas[indexPath.row].realizado
        do {
            try AppDelegate.context.save()
            tablaActividades.reloadData()
        } catch let error as NSError {
            print("El contacto no fue guardado")
            print("Error \(error) \(error.userInfo)")
        }
    }
    
    func setCellAccesory(cell: UITableViewCell, filled: Bool){
        var image = #imageLiteral(resourceName: "uncheck")
        if filled {
            image = #imageLiteral(resourceName: "checked")
        }
        let imageView = UIImageView.init(image: image)
        imageView.contentMode = .scaleAspectFill
        cell.accessoryView = imageView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reprogramar" {
            let vista = segue.destination as! ReprogramarActividadViewController
            vista.actividadAReprogramar = actividadesRealizadas[actividadSeleccionado]
        }
        
    }

}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func dayNumberOfWeek() -> Int! {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func toDateString() -> String! {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL dd"
        formatter.locale = Locale(identifier: "es_MX")
        let diaFormateado = formatter.string(from: self)
        return diaFormateado
    }
    
    func toTimestamp() -> Int? {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    func getTodayString() -> String{
        
        let date = self
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
