//
//  AgregarActividadViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/3/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData

class AgregarActividadViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    func ponerDias(diasSeleccionados: [Bool]) {
        //
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pickerFechaUnica: UIDatePicker!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tipoActividad: UISegmentedControl!
    @IBOutlet weak var horaAlarma: UIDatePicker!
    @IBOutlet weak var elegirDias: UIButton!
    var goWeek = false
    //@IBOutlet weak var weekTable: UITableView!
    var recibeSemana = [Bool]()
    var loGuardo = false
    var nuevaActividad: Actividad!
    var arrayFrecuencias = ["Una vez", "Semanal"]
    
    var diasSeleccionados = [false, false, false, false, false, false, false]
    
    var frecuenciaSeleccionada: String = ""
    @IBOutlet weak var pickerFrecuencia: UIPickerView!
    
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loGuardo = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        view.addGestureRecognizer(tap)
        scrollView.contentSize = contentView.frame.size
        pickerFrecuencia.delegate = self
        pickerFrecuencia.dataSource = self
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
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
    
    @IBAction func unwindDiasSemana(unwindSegue: UIStoryboardSegue){
        print("unwind")
        dump(diasSeleccionados)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        goWeek = true
        if segue.identifier == "tableWeekDays"{
            let vistaTabla = segue.destination as! DiasSemanaViewController
            vistaTabla.diasSeleccionados = diasSeleccionados
            
        }
    }
 
}
