//
//  CellViewController.swift
//  consultaRepos
//
//  Created by fernando.calle.silos on 4/5/18.
//  Copyright © 2018 fernando.calle.silos. All rights reserved.
//

import UIKit

protocol DelegadoCelda: class {
    func irADetalleCelda ( _ sender: CellViewController)
}

class CellViewController: UITableViewCell {
    
    
    weak var delegate: DelegadoCelda?
    
    @IBOutlet weak var titulo: UILabel!
    
    @IBAction func irADetalle(_ sender: Any) {
        delegate?.irADetalleCelda(self)
    }
    
    
    
}
