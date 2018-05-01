//
//  EmergenciasViewController.swift
//  SaludIntegral
//
//  Created by Alumno on 07/03/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData

class EmergenciasViewController: UIViewController {

    @IBOutlet weak var lbNombreFamiliar: UILabel!
    @IBOutlet weak var lbNombreMedico: UILabel!
    @IBOutlet weak var lbNombreEmergencia: UILabel!
    
    @IBOutlet weak var lbLlamar1: UIButton!
    @IBOutlet weak var btMedico: UIButton!
    @IBOutlet weak var btEmergencia: UIButton!
    var telFamilia : String!
    var telMedico : String!
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
    
    func obtenerDatosEmergencias() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let contactos = try context.fetch(Contacto.fetchRequest()) as [Contacto]
            for contacto in contactos {
                if contacto.tipo == TipoContacto.Familiar.rawValue {
                    lbNombreFamiliar.text = contacto.nombre
                    telFamilia = contacto.telefono
                } else if contacto.tipo == TipoContacto.Medico.rawValue {
                    lbNombreMedico.text = contacto.nombre
                    telMedico = contacto.telefono
                } else if contacto.tipo == TipoContacto.Emergencias.rawValue {
                    lbNombreEmergencia.text = contacto.nombre
                    telEmergencia = contacto.nombre
                }
            }
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    
    @IBAction func llamarFamiliar(_ sender: UIButton) {
        //let url: NSURL = URL(string:telFamilia)! as NSURL
        if let url = URL(string:"TEL://\(telFamilia)") {
            print(telFamilia)
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        else{
            //No hay telefono
            let alertaA = UIAlertController(title: "No hay contacto guardado", message: ":)", preferredStyle: .alert)
            alertaA.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertaA, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func llamarMedico(_ sender: UIButton) {
        if let url = URL(string:"TEL://\(telMedico)") {
            print(telMedico)
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        else{
            //No hay telefono
            let alertaA = UIAlertController(title: "No hay contacto guardado", message: ":)", preferredStyle: .alert)
            alertaA.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertaA, animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func llamarEmergencia(_ sender: UIButton) {
        if let url = URL(string:"TEL://\(telEmergencia)") {
            print(telEmergencia)
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        } else {
            //No hay telefono
            let alertaA = UIAlertController(title: "No hay contacto guardado", message: ":)", preferredStyle: .alert)
            alertaA.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertaA, animated: true, completion: nil)
            
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
