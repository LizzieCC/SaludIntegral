//
//  EditarContactosViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 3/10/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData

/// Controlador encargado de editar la informacion de los contactos.
class EditarContactosViewController: UIViewController, UITextFieldDelegate {
    
    /// No permite que el dispositivo se rote.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
   
    @IBOutlet weak var tfTelEmergencia: UITextField!
    @IBOutlet weak var tfNombreEmergencia: UITextField!
    @IBOutlet weak var tfTelMedico: UITextField!
    @IBOutlet weak var tfNombreMedico: UITextField!
    @IBOutlet weak var tfTelFamilia: UITextField!
    @IBOutlet weak var tfNombreFamilia: UITextField!
    var activeField : UITextField!
    /// Si se deberia o no mover la vista por el teclado.
    var moveKey = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(EditarContactosViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditarContactosViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /// Quita el teclado cuando el usuario deselecciona el campo.
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    /// Se configura para que cuando se muestre el teclado se mueva la vista para arriba.
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && moveKey{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    /// Se configura para que se regrese a su estado original cualel teclado desaparezca.
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 && moveKey{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    /// Determina si un textfield necesita que se mueva la vista hacia arriba.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("did begin")
        if textField.tag == 1 || textField.tag == 2 {
            moveKey = false
            print("no se debe ir")
        }
        else{
            //Nada
            moveKey = true
            print("nada")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    /// Obtiene todos los datos de los contactos (familiar, medico y emergencias)
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
    
    /// Guarda la informacion de los contactos en la base de datos.
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

    /// Checa y guarda, si esta correcto, la informacion de los contactos.
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
