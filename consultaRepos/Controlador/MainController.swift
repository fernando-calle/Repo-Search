//
//  MainController.swift
//  consultaRepos
//
//  Created by fernando.calle.silos on 3/5/18.
//  Copyright © 2018 fernando.calle.silos. All rights reserved.
//

import Foundation

/*
 Controlador principal de la vista principal
 */
class MainController {
    let vista: ViewUI?
    let paginaInicial = 1
    var paginaActual = 1
    var paginaFinal: Int?
    var urlGeneral = "https://api.github.com/repositories?access_token=e3f838c0bfe93db5675887c20567910ca2434052"
    var valorBusqueda: String? //Nombre del repo a buscar
    
    init(vista: ViewUI) {
        self.vista = vista
    }
    
    //Función que busca todos los repos
    func buscarTodos() {
        self.paginaActual = 1
        let url = URL(string: urlGeneral)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in guard let data = data else {
            return
            }
            //Creo un decoder que asigna el resultado de la consulta a la API en formato JSON a un Modelo en formato Struct
            let decoder = JSONDecoder()
            if let JSON = try? decoder.decode([Repo].self, from: data) {
                DispatchQueue.main.async {
                    self.vista?.actualizarTabla(datos: JSON) //Una vez finalizado, recargo la tabla con el método delegado
                }
                
            }
            
        }.resume()

        
    }
    //Función que busca repos por texto
    func buscarPorNombre(nombre:String,pagina:Int) {
        self.valorBusqueda = nombre //Repo a buscar
        let urlBusqueda =  "https://api.github.com/search/repositories?q=\(nombre)&page=\(pagina)&per_page=10"
        let url = URL(string: urlBusqueda.replacingOccurrences(of: " ", with: "")) //Escapo posibles espacios en blanco
        URLSession.shared.dataTask(with: url!) { (data, response, error) in guard let data = data else {
            return
            }
            let decoder = JSONDecoder()
            if let JSON = try? decoder.decode(RepoSearch.self, from: data) {
                DispatchQueue.main.async {
                    var paginas = JSON.totalCount
                    if paginas % 2 != 0 {paginas = paginas + 1} //El número total de páginas será redondeado para agrupar de 10 en 10
                    self.paginaFinal = paginas
                    self.vista?.actualizarTabla(datos: JSON.items)
                    
                }
                
            }
            
            }.resume()
        
    }
    
    //Método de avance de página
    func paginaSiguiente() {
        
        self.paginaActual += 1
        self.vista?.mostrarAnterior()
        buscarPorNombre(nombre: valorBusqueda!, pagina: paginaActual)
        
        if paginaActual == paginaFinal! {
            self.vista?.ocultarSiguiente()
        }
    }
    //Método de retroceso de página
    func paginaAnterior() {
        
        self.paginaActual -= 1
        self.vista?.mostrarSiguiente()

        buscarPorNombre(nombre: valorBusqueda!, pagina: paginaActual)
        
        if paginaActual == paginaInicial {
            self.vista?.ocultarAnterior()
        }
        
    }
}
