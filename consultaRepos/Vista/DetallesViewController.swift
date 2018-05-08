//
//  DetallesViewController.swift
//  consultaRepos
//
//  Created by fernando.calle.silos on 4/5/18.
//  Copyright © 2018 fernando.calle.silos. All rights reserved.
//

import UIKit


final class DetallesViewController: UIViewController {
    
    var repositorio:Repo?
    
    @IBOutlet weak var titulo: UINavigationItem!
    @IBOutlet weak var descripcion: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let repoDato = repositorio {
            self.titulo.title = repoDato.name
            self.descripcion.text = repoDato.fullName
        }
    }
    
    @IBAction func volver(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
