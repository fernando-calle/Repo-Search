//
//  TablaViewController.swift
//  consultaRepos
//
//  Created by fernando.calle.silos on 4/5/18.
//  Copyright © 2018 fernando.calle.silos. All rights reserved.
//

import UIKit
//Protocolo para delegar funciones de la tabla
protocol DelegadoTabla : class {
    func detalleCelda (_ sender: TablaViewController)
}
//Controlador encargado de manejar la tabla
class TablaViewController: UITableViewController, DelegadoCelda {
    
    
    var repositorios:[Repo]?
    var longitud = 10
    var celda:CellViewController?
    weak var delegate: DelegadoTabla?
    
    init(repositorios:[Repo]){
        self.repositorios = repositorios
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Delegado celda
    
    //Método delegado para mostrar detalles de un repo
    func irADetalleCelda(_ sender: CellViewController) {
        self.celda = sender
        delegate?.detalleCelda(self)
    }
    
    //Función para actualizar datos de la tabla
    func recargarDatos(repositorios:[Repo]){
            self.repositorios = repositorios
    }
    
    
    //MARK: Delegado tabla
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return (repositorios?.count)!
        
    }
    
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoData", for: indexPath) as! CellViewController
        var text = ""
        cell.delegate = self
        text = self.repositorios![indexPath.row].name
        cell.titulo.text = text
    
        return cell //4.
    }
    
    
}
