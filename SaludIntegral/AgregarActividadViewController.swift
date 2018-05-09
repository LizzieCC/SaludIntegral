//
//  AgregarActividadViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/3/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData

/// Controlador que se encarga de agregar una nueva actividad.
class AgregarActividadViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    func ponerDias(diasSeleccionados: [Bool]) {
        //
    }
    
    /// No permite al dispositivo que se pueda rotar.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    @IBOutlet weak var pickerFechaUnica: UIDatePicker!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tipoActividad: UISegmentedControl!
    @IBOutlet weak var horaAlarma: UIDatePicker!
    @IBOutlet weak var elegirDias: UIButton!
    /// Determina si se fue a la pantalla de seleccionar las semanas para la actividad.
    var goWeek = false
    //@IBOutlet weak var weekTable: UITableView!
    var recibeSemana = [Bool]()
    /// Determina si se guardara la actividad o no.
    var loGuardo = false
    /// La informacion de la actividad que se quiere agregar.
    var nuevaActividad: Actividad!
    /// Los tipos de frecuencia disponibles para la actividad.
    var arrayFrecuencias = ["Una vez", "Semanal"]
    /// Los dias de la semana que se seleccionaron para realizar la actividad.
    var diasSeleccionados = [false, false, false, false, false, false, false]
    /// La frecuencia que fue seleccionada por el usuario.
    var frecuenciaSeleccionada: String = ""
    @IBOutlet weak var pickerFrecuencia: UIPickerView!
    
    /// Quita el teclado cuando el usuario deselecciona el campo.
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loGuardo = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        view.addGestureRecognizer(tap)
        pickerFrecuencia.delegate = self
        pickerFrecuencia.dataSource = self
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Crea una nueva actividad si no existe ya una definida.
        if(nuevaActividad == nil) {
            nuevaActividad = NSEntityDescription.insertNewObject(forEntityName: "Actividad", into: context) as! Actividad
        }
        
        tfNombre.text = nuevaActividad.titulo
        frecuenciaSeleccionada = arrayFrecuencias[Int(nuevaActividad.tipoFrecuencia)]
        pickerFrecuencia.selectRow(Int(nuevaActividad.tipoFrecuencia), inComponent: 0, animated: true)
        actualizarFrecuencia()
        if let frecuenciaSemana = nuevaActividad.frecuenciaSemana {
            diasSeleccionados = frecuenciaSemana
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //TableView
    
   /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diasSemana.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weekTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let dia = diasSemana[indexPath.row]
        cell.textLabel?.text = dia as String
        if diasSeleccionados[indexPath.row]{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        diasSeleccionados[indexPath.row] = !diasSeleccionados[indexPath.row]
        if diasSeleccionados[indexPath.row]{
            weekTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            weekTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }
        
    }*/
    //Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayFrecuencias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayFrecuencias[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        frecuenciaSeleccionada = arrayFrecuencias[row]
        actualizarFrecuencia()
    }
    
    /// Muestra o quita los elementos de la nueva frecuencia seleccionada.
    func actualizarFrecuencia() {
        switch frecuenciaSeleccionada {
        case arrayFrecuencias[0]:
            pickerFechaUnica.isHidden = false
            elegirDias.isHidden = true
            break
        case arrayFrecuencias[1]:
            pickerFechaUnica.isHidden = true
            elegirDias.isHidden = false
            break
        default:
            break
        }
    }
    
    
    /// Agrega la actividad a la base de datos.
    @IBAction func agregarActividad(_ sender: UIButton) {
        loGuardo = true
        print("unwind")
        dump(diasSeleccionados)
        let tipoFrecuencia = Int32(arrayFrecuencias.index(of: frecuenciaSeleccionada)!)
        if let nombre = tfNombre.text, !nombre.isEmpty && (tipoFrecuencia != TipoFrecuencia.Semanal.rawValue || (tipoFrecuencia == TipoFrecuencia.Semanal.rawValue && diasSeleccionados.index(of: true) != nil)) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            nuevaActividad.titulo = nombre
            
            nuevaActividad.alarma = horaAlarma.date as NSDate
            nuevaActividad.tipoFrecuencia = tipoFrecuencia
            if(nuevaActividad.tipoFrecuencia == TipoFrecuencia.Uno.rawValue) {
                nuevaActividad.fechaProgramada = pickerFechaUnica.date as NSDate
            } else if(nuevaActividad.tipoFrecuencia == TipoFrecuencia.Semanal.rawValue) {
                print("guardar frecuencia")
                dump(diasSeleccionados)
                
                nuevaActividad.frecuenciaSemana = diasSeleccionados
                
                print("ver frecuencia")
                dump(nuevaActividad.frecuenciaSemana)
            }
            nuevaActividad.area = Int32(tipoActividad.selectedSegmentIndex)
            
            do {
                try context.save()
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.agregarNotificacion(actividad: nuevaActividad)
                navigationController?.popViewController(animated: true)
            } catch let error as NSError {
                print("La actividad no fue guardado")
                print("Error \(error) \(error.userInfo)")
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Es necesario llenar toda la informacion de la actividad", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
   
 
   override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        print("View will disappear")
    
        if !loGuardo && !goWeek {
            context.delete(nuevaActividad)
            do {
                try context.save()
            } catch _ {
            }
        }
    }
    
    /// Pasa los datos de los dias de la semana al ya seleccionarlos.
    @IBAction func unwindDiasSemana(unwindSegue: UIStoryboardSegue){
        print("unwind")
        dump(diasSeleccionados)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pasa los datos para poder seleccionar los dias de la semana.
        goWeek = true
        if segue.identifier == "tableWeekDays"{
            let vistaTabla = segue.destination as! DiasSemanaViewController
            vistaTabla.diasSeleccionados = diasSeleccionados
            
        }
    }
 
}
