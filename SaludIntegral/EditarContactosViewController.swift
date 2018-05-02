//
//  EditarContactosViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 3/10/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData

class EditarContactosViewController: UIViewController {
   
    @IBOutlet weak var tfTelEmergencia: UITextField!
    @IBOutlet weak var tfNombreEmergencia: UITextField!
    @IBOutlet weak var tfTelMedico: UITextField!
    @IBOutlet weak var tfNombreMedico: UITextField!
    @IBOutlet weak var tfTelFamilia: UITextField!
    @IBOutlet weak var tfNombreFamilia: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacto")
            
            request.predicate = NSPredicate(format: "tipo == \(TipoContacto.Familiar.rawValue)")
            let contactoFamiliar = try AppDelegate.context.fetch(request) as!  [Contacto]
            if contactoFamiliar.count > 0 {
                tfNombreFamilia.text = contactoFamiliar[0].nombre
                tfTelFamilia.text = contactoFamiliar[0].telefono
            }
            
            request.predicate = NSPredicate(format: "tipo == \(TipoContacto.Medico.rawValue)")
            let contactoMedico = try AppDelegate.context.fetch(request) as! [Contacto]
            if contactoMedico.count > 0 {
                tfNombreMedico.text = contactoMedico[0].nombre
                tfTelMedico.text = contactoMedico[0].telefono
            }
            
            request.predicate = NSPredicate(format: "tipo == \(TipoContacto.Emergencias.rawValue)")
            let contactoEmergencias = try AppDelegate.context.fetch(request) as! [Contacto]
            if contactoEmergencias.count > 0 {
                tfNombreEmergencia.text = contactoEmergencias[0].nombre
                tfTelEmergencia.text = contactoEmergencias[0].telefono
            }
        }
        catch {
            print("Fetching Failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func guardar(tipo: TipoContacto, nombre: String, telefono: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacto")
        request.predicate = NSPredicate(format: "tipo == \(tipo.rawValue)")
        
        do{
            let results = try AppDelegate.context.fetch(request)
            if results.count > 0 {
                let contacto = results[0] as! NSManagedObject
                contacto.setValue(nombre, forKey: "nombre")
                contacto.setValue(telefono, forKey: "telefono")
                contacto.setValue(tipo.rawValue, forKey: "tipo")
                do {
                    try AppDelegate.context.save()
                } catch let error as NSError {
                    print("El contacto no fue guardado")
                    print("Error \(error) \(error.userInfo)")
                }
            } else {
                let contacto = NSEntityDescription.insertNewObject(forEntityName: "Contacto", into: AppDelegate.context) as! Contacto
                contacto.tipo = Int32(tipo.rawValue)
                contacto.setValue(nombre, forKey: "nombre")
                contacto.setValue(telefono, forKey: "telefono")
                do {
                    try AppDelegate.context.save()
                } catch let error as NSError {
                    print("El contacto no fue guardado")
                    print("Error \(error) \(error.userInfo)")
                }
            }
            
        } catch {
            print("El contacto no fue guardado")
        }
    }

    @IBAction func guardarContactos(_ sender: UIButton) {
        if(!(tfNombreFamilia.text?.isEmpty)! && !(tfTelFamilia.text?.isEmpty)! && !(tfNombreMedico.text?.isEmpty)! && !(tfTelMedico.text?.isEmpty)! && !(tfNombreEmergencia.text?.isEmpty)! && !(tfTelEmergencia.text?.isEmpty)!) {
            guardar(tipo: TipoContacto.Familiar, nombre: tfNombreFamilia.text!, telefono: tfTelFamilia.text!)
            guardar(tipo: TipoContacto.Medico, nombre: tfNombreMedico.text!, telefono: tfTelMedico.text!)
            guardar(tipo: TipoContacto.Emergencias, nombre: tfNombreEmergencia.text!, telefono: tfTelEmergencia.text!)
            
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Es necesario llenar toda la informacion de los contactos", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
