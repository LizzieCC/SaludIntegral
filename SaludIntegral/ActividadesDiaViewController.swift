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

/// Maneja la agenda de todas las actividades.
class ActividadesDiaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    @IBOutlet weak var tablaActividades: UITableView!
    @IBOutlet weak var lbDia: UILabel!
    
    /// Contiene el template de las actividades que se deben realizar el dia seleccionado.
    var actividadesHoy: [Actividad] = []
    /// Contiene las actividades que se deben realizar el dia seleccionado.
    var actividadesRealizadas: [ActividadDia] = []
    /// El dia actual que fue seleccionado por el usuario.
    var diaSeleccionado: Date = Date()
    /// Contiene referencia de la actividad que se selecciono al picarle.
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
    
    /// Agrega la opcion de reprogramar en sus acciones.
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let reprogramarAction = UITableViewRowAction(style: .normal, title: "Reprogramar") { action, index in
            
        }
        reprogramarAction.backgroundColor = .orange
        return [reprogramarAction]
    }
    
    /// Obteiene todas las actividades que e van a realizar el dia seleccionado en base a un template.
    ///
    /// - parameter actividad: Contiene el template de la actividad del cual se desea todas sus actividades del dia seleccionado.
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
    
    /// Obtiene todos los datos de las actividades del dia seleccionado.
    func obtenerDatosActividades() {
        actividadesHoy.removeAll()
        actividadesRealizadas.removeAll()
        
        // Obtiene las actividades semanales
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
        
        // Obtiene las actividades que se realizan una sola vez.
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
    
    /// Cambia las actividades al dia anterior del actual.
    @IBAction func anteriorDia(_ sender: UIButton) {
        diaSeleccionado = diaSeleccionado.yesterday
        actualizarDia()
        obtenerDatosActividades()
    }
    
    /// Cambia las actividades al dia posterior del actual.
    @IBAction func siguienteDia(_ sender: UIButton) {
        diaSeleccionado = diaSeleccionado.tomorrow
        actualizarDia()
        obtenerDatosActividades()
    }
    
    /// Actualiza el texto del dia actual al nuevo dia seleccionado.
    func actualizarDia() {
        lbDia.text = String(describing: diaSeleccionado.dayOfWeek()!) + ", " +
        (diaSeleccionado.toDateString()!)
    }
    
    /// Recarga los datos de las actividades.
    func actualizarActividades() {
        tablaActividades.reloadData()
    }
    
    /// Ajusta el alto de las celda de la tabla para que se vea de forma correcta.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /// Modifica la celda para que contenga un el titulo de la actividad y un checkbox que indica si fue realizada la actividad o no.
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
        // Mantiene registro de la celda seleccionada.
        actividadSeleccionado = indexPath.row
        return indexPath
    }
    
    /// Actualiza si la actividad fue realizada o no, cambiandolo en la base de datos.
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
    
    /// Agrega el checkbox dejandolo checked o unchecked dependiendo de si fue realizado o no.
    ///
    /// - parameter cell: Contiene la celda que se desea modificar su checkbox.
    /// - parameter filled: Si se pondra checked o unchecked en el checkbox.
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
        // Si se va a reprogramar actividad manda los datos que necesita.
        
        
    }

}

/// Contiene extensiones utiles para obtener fechas.
extension Date {
    /// Obtiene el dia de la semana en texto.
    ///
    /// - returns: El nombre del dia de la semana.
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    /// Obtiene el dia de la semana.
    ///
    /// - returns: El numero del dia de la semana.
    func dayNumberOfWeek() -> Int! {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    /// Convierte la fecha en texto legible, mostrando mes y dia.
    ///
    /// - returns: Mes y dia de la fecha.
    func toDateString() -> String! {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL dd"
        formatter.locale = Locale(identifier: "es_MX")
        let diaFormateado = formatter.string(from: self)
        return diaFormateado
    }
    
    /// Convierte la fecha en un timestamp.
    ///
    /// - returns: El timestamp de la fecha.
    func toTimestamp() -> Int? {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    /// Obtiene la fecha anterior al seleccionado.
    ///
    /// - returns: El dia anterior de la fecha.
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }

    /// Obtiene la fecha despues al seleccionado.
    ///
    /// - returns: El dia posterior de la fecha.
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }

    /// Obtiene la madrugada de la fecha.
    ///
    /// - returns: La fecha en la madrugada.
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    /// Obtiene el mes de la fecha.
    ///
    /// - returns: El numero del mes de la fecha.
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }

    /// Checa si la fecha es el ultimo dia del mes.
    ///
    /// - returns: Si o no es el ultimo dia del mes.
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    /// Obtiene el dia actual en formato de fecha.
    ///
    /// - returns: El texto de la fecha.
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
    
    /// Obtiene el primer dia del mes de la fecha.
    ///
    /// - returns: La fecha del inicio de mes.
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    /// Obtiene el ultimo dia del mes de la fecha.
    ///
    /// - returns: La fecha del final de mes.
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
