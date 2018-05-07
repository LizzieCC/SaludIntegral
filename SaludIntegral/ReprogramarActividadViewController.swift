//
//  ReprogramarActividadViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 4/24/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData

class ReprogramarActividadViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    var actividadAReprogramar: ActividadDia!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var pickerFecha: UIDatePicker!
    @IBOutlet weak var pickerHora: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = contentView.frame.size
        pickerFecha.date = actividadAReprogramar.fecha as Date
        if let hora = actividadAReprogramar.hora as? Date {
            pickerHora.date = hora
        }
        lbNombre.text = actividadAReprogramar.actividad?.titulo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func reprogramarActividad(_ sender: UIButton) {
        let nuevaActividadDia = NSEntityDescription.insertNewObject(forEntityName: "ActividadDia", into: AppDelegate.context) as! ActividadDia
        nuevaActividadDia.fecha = pickerFecha.date as NSDate
        nuevaActividadDia.hora = pickerHora.date as NSDate
        nuevaActividadDia.actividad = actividadAReprogramar.actividad
        actividadAReprogramar.reprogramado = true
        nuevaActividadDia.realizado = actividadAReprogramar.realizado
        print(nuevaActividadDia)
        
        do {
            try AppDelegate.context.save()
            navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("La actividad no fue guardado")
            print("Error \(error) \(error.userInfo)")
        }
    }
    

}
