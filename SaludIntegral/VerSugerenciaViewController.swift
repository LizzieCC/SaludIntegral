//
//  VerSugerenciaViewController.swift
//  
//
//  Created by LIZZIE M. CANAMAR on 4/8/18.
//

import UIKit
import CoreData

/// Controlador que muestra a detalle una sugerencia.
class VerSugerenciaViewController: UIViewController {
    
    /// No permite que el dispositivo se rote.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }

    @IBOutlet weak var lbDescripcion: UILabel!
    @IBOutlet weak var imageSugerencia: UIImageView!
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var webView: UIWebView!
    /// Contiene la informacion de la sugerencia actual.
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
    
    /// Carga el video de la sugerencia en caso de tener uno.
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
    
    /// Manda la informacion de la actividad de la sugerencia para poderla agregar.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vista = segue.destination as! AgregarActividadViewController
        
        let actividad = NSEntityDescription.insertNewObject(forEntityName: "Actividad", into: AppDelegate.context) as! Actividad
        actividad.titulo = sugerencia.titulo!
        actividad.tipoFrecuencia = sugerencia.tipoFrecuencia
        actividad.frecuenciaSemana = sugerencia.frecuenciaSemana
        
        
        vista.nuevaActividad = actividad
    }

}
