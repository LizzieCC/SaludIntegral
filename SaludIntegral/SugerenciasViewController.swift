//
//  SugerenciasViewController.swift
//  SaludIntegral
//
//  Created by Alumno on 07/03/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

class SugerenciasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    @IBOutlet weak var tablaSugerencias: UITableView!
    @IBOutlet weak var tabBarAreas: UITabBar!
    
    var sugerencias = [Sugerencia]()
    var sugerenciasActuales:  [Sugerencia] = []
    var areaActual: Area = Area.Fisico

    override func viewDidLoad() {
        super.viewDidLoad()
        tablaSugerencias.delegate = self
        tablaSugerencias.dataSource = self
        tabBarAreas.delegate = self
        tabBarAreas.selectedItem = (self.tabBarAreas.items as! [UITabBarItem])[0]
        
        SugerenciasFactory.agregarSugerencias()
        actualizarSugerencias()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaSugerencias.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SugerenciasTableViewCell
        let sugerencia = sugerenciasActuales [indexPath.row]
        cell.lbTitulo.text = sugerencia.titulo
       // cell.lbDetalle.text = sugerencia.descripcion
        if let imagen = sugerencia.imagen {
            print(imagen)
            let url = URL(string: imagen)
            do {
                let data = try Data(contentsOf: url!)
                cell.imagen.image = UIImage(data: data)
            } catch {
                
            }
        }
        return cell;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sugerenciasActuales.count
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item:UITabBarItem) {
        var items = (self.tabBarAreas.items as! [UITabBarItem])
        if item == items[0] {
            areaActual = Area.Fisico
        }
        else if item == items[1] {
            areaActual = Area.Mental
        }
        else if item == items[2] {
            areaActual = Area.Financiero
        }
        else if item == items[3] {
            areaActual = Area.Espiritual
        }
        print(areaActual)
        actualizarSugerencias()
    }
    
    func actualizarSugerencias() {
        let fetchSugerencias = NSFetchRequest<NSFetchRequestResult>(entityName: "Sugerencia")
        fetchSugerencias.predicate = NSPredicate(format: "area == \(areaActual.rawValue)")
        fetchSugerencias.sortDescriptors = [NSSortDescriptor(key: #keyPath(Sugerencia.prioridad), ascending: true)]
        do {
            sugerenciasActuales = try AppDelegate.context.fetch(fetchSugerencias) as! [Sugerencia]
        } catch {
            fatalError("Error: \(error)")
        }
        tablaSugerencias.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vista = segue.destination as! VerSugerenciaViewController
        let index = tablaSugerencias.indexPathForSelectedRow
        vista.sugerencia = sugerenciasActuales[(index?.row)!]
    }

}
