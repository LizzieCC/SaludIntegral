//
//  DiasSemanaViewController.swift
//  SaludIntegral
//
//  Created by LIZZIE M. CANAMAR on 5/3/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit

class DiasSemanaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var diasSemana = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"]
    var diasSeleccionados = [Bool]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diasSemana.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dia = diasSemana[indexPath.row]
        cell.textLabel?.text = dia as String
        if diasSeleccionados[indexPath.row]{
         cell.accessoryType = UITableViewCellAccessoryType.checkmark
         }else{
         cell.accessoryType = UITableViewCellAccessoryType.none
         }
        // Configure the cell...
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        diasSeleccionados[indexPath.row] = !diasSeleccionados[indexPath.row]
         if diasSeleccionados[indexPath.row] {
         tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
         } else {
         tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
         }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vistaAgregar = segue.destination as! AgregarActividadViewController
        vistaAgregar.diasSeleccionados = diasSeleccionados
        print("o no")
    }


}
