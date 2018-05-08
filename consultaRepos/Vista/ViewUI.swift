//
//  ViewUI.swift
//  consultaRepos
//
//  Created by fernando.calle.silos on 8/5/18.
//  Copyright © 2018 fernando.calle.silos. All rights reserved.
//

import Foundation

protocol  ViewUI {
    func actualizarTabla(datos: [Repo])
    func ocultarAnterior()
    func ocultarSiguiente()
    func mostrarSiguiente()
    func mostrarAnterior()
}
