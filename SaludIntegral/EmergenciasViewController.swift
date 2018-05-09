//
//  EmergenciasViewController.swift
//  SaludIntegral
//
//  Created by Alumno on 07/03/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData

/// Controlador que contiene y llama a los contactos de emergencia.
class EmergenciasViewController: UIViewController {
    
    /// No permite que el dispositivo se rote.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }

    @IBOutlet weak var lbNombreFamiliar: UILabel!
    @IBOutlet weak var lbNombreMedico: UILabel!
    @IBOutlet weak var lbNombreEmergencia: UILabel!
    
    @IBOutlet weak var lbLlamar1: UIButton!
    @IBOutlet weak var btMedico: UIButton!
    @IBOutlet weak var btEmergencia: UIButton!
    /// Contiene el telefono del familiar.
    var telFamilia : String!
    /// Contiene el telefono del medico.
    var telMedico : String!
    /// Contiene el telefono de emergencias.
    var telEmergencia : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerDatosEmergencias()
        lbLlamar1.layer.cornerRadius = 10
        lbLlamar1.layer.borderWidth = 0
        
        btMedico.layer.cornerRadius = 10
        btMedico.layer.borderWidth = 0
        
        btEmergencia.layer.cornerRadius = 10
        btEmergencia.layer.borderWidth = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        obtenerDatosEmergencias()
    }
    
    /// Obtiene la informacion de contactos de la base de datos.
    func obtenerDatosEmergencias() {
        do {
            let contactos = try AppDelegate.context.fetch(Contacto.fetchRequest()) as [Contacto]
            for contacto in contactos {
                if contacto.tipo == TipoContacto.Familiar.rawValue {
                    lbNombreFamiliar.text = contacto.nombre
                    telFamilia = contacto.telefono
                } else if contacto.tipo == TipoContacto.Medico.rawValue {
                    lbNombreMedico.text = contacto.nombre
                    telMedico = contacto.telefono
                } else if contacto.tipo == TipoContacto.Emergencias.rawValue {
                    lbNombreEmergencia.text = contacto.nombre
                    telEmergencia = contacto.telefono
                }
            }
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    /// Llama al familiar.
    @IBAction func llamarFamiliar(_ sender: UIButton) {
        if telFamilia == nil {
            //No hay telefono
            let alertaA = UIAlertController(title: "No hay contacto guardado", message: ":)", preferredStyle: .alert)
            alertaA.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertaA, animated: true, completion: nil)
        } else if let url = URL(string:"TEL://\(telFamilia!)") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    /// Llama al medico.
    @IBAction func llamarMedico(_ sender: UIButton) {
        if telMedico == nil {
            //No hay telefono
            let alertaA = UIAlertController(title: "No hay contacto guardado", message: ":)", preferredStyle: .alert)
            alertaA.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertaA, animated: true, completion: nil)
        } else if let url = URL(string:"TEL://\(telMedico!)") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    /// Llama a emergencias.
    @IBAction func llamarEmergencia(_ sender: UIButton) {
        if telEmergencia == nil {
            //No hay telefono
            let alertaA = UIAlertController(title: "No hay contacto guardado", message: ":)", preferredStyle: .alert)
            alertaA.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertaA, animated: true, completion: nil)
        } else if let url = URL(string:"TEL://\(telEmergencia!)") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func unwindEditar(unwindSegue : UIStoryboardSegue) {
        
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let vistaEditar = segue.destination as! EditarContactosViewController
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
