//
//  VerSugerenciaViewController.swift
//  
//
//  Created by LIZZIE M. CANAMAR on 4/8/18.
//

import UIKit
import CoreData


class VerSugerenciaViewController: UIViewController {

    @IBOutlet weak var lbDescripcion: UILabel!
    @IBOutlet weak var imageSugerencia: UIImageView!
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var sugerencia: Sugerencia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbNombre.text = sugerencia.titulo
        lbDescripcion.text = sugerencia.descripcion
        cargarVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cargarVideo() {
        if let video = sugerencia.video {
            let url = URL(string: video)
            webView.loadRequest(URLRequest(url: url!))
        } else {
            webView.isHidden = true
        }
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print("si llega a unwind ver sugerencia")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vista = segue.destination as! AgregarActividadViewController
        
        let actividad = NSEntityDescription.insertNewObject(forEntityName: "Actividad", into: AppDelegate.context) as! Actividad
        actividad.titulo = sugerencia.titulo!
        actividad.tipoFrecuencia = sugerencia.tipoFrecuencia
        actividad.frecuenciaSemana = sugerencia.frecuenciaSemana
        
        
        vista.nuevaActividad = actividad
    }

}
