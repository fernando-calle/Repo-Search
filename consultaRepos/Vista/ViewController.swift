//
//  ViewController.swift
//  consultaRepos
//
//  Created by fernando.calle.silos on 3/5/18.
//  Copyright © 2018 fernando.calle.silos. All rights reserved.
//

import UIKit

/*
 Vista principal de la aplicación
 */

class ViewController: UIViewController ,UITextFieldDelegate, DelegadoTabla, ViewUI {
    
  
  
    var tablaRepositorios:TablaViewController? //Controlador de la tabla
    var controlador: MainController? //Controlador principal
    

    @IBOutlet weak var repoList: UITableView! //Tabla de la vista
    @IBOutlet weak var busquedaTextField: UITextField! //Campo de texto para búsquea
    @IBOutlet weak var paginaAnterior: UIButton! //Botón de página anterior
    @IBOutlet weak var paginaSiguiente: UIButton! //Botón de página siguiente
    
    
    
    override func viewDidLoad() {
        tablaRepositorios = TablaViewController(repositorios: [Repo]()) //Asigno una lista vacía para inicializar la tabla
        tablaRepositorios?.delegate = self //Asigno el controlador de tabla a la tabla
        repoList.dataSource = tablaRepositorios //Asigno el repositio de datos de la tabla al controlador de la tabla
        repoList.delegate = tablaRepositorios //Asigno como delegado de tabla el controlador de tabla
        busquedaTextField.delegate = self
        self.controlador = MainController(vista: self) //Creo el controlador principal
        self.controlador?.buscarTodos() //Realizo una búsqueda inicial de todos los repositorios
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    //MARK: Actions
 
    //Acción de buscar repositorios
    @IBAction func buscarRepos(_ sender: Any) {
        buscar()
    }
    
    //Acción para regresar a todos los repos
    @IBAction func limpiarTabla(_ sender: Any) {
        //Oculto los botones anterior y siguiente
        ocultarAnterior()
        ocultarSiguiente()
        self.controlador?.buscarTodos()
    }
    
    //Acción de retoceder página
    @IBAction func retrocederPagina(_ sender: Any) {
        self.controlador?.paginaAnterior()
       
    }
    
    //Acción de avanzar página
    @IBAction func avanzarPagina(_ sender: Any) {
        self.controlador?.paginaSiguiente()
    }
    
    //Acción de buscar repo tomando texto del textfield
    func buscar() {
        if let textoBusqueda = self.busquedaTextField.text{
            mostrarSiguiente()
            self.controlador?.buscarPorNombre(nombre: textoBusqueda, pagina: 1)
        }
    }
    
    //MARK: Segue
    
    //Segue hacia detalles
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detallesSegue" {
            guard let detallesViewController = segue.destination as? DetallesViewController
                 else {
                    
                    return
            }
            if let data:Repo  = sender as? Repo  {
                detallesViewController.repositorio = data //Relleno la variable de la vista destino

            }
         
        }
    }
    
    //MARK: TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {  
        busquedaTextField.resignFirstResponder()
        buscar()
        return true
    }
    
    //MARK: UI Delegate
    
    //Función delegada que recarga la tabla con los datos recibidos de consultar la API
    func actualizarTabla(datos: [Repo]) {
        self.tablaRepositorios?.recargarDatos(repositorios: datos)
        self.repoList.reloadData()
    }
    func ocultarAnterior() {
        self.paginaAnterior.isHidden = true
    }
    func ocultarSiguiente() {
        self.paginaSiguiente.isHidden = true
    }
    func mostrarSiguiente() {
        self.paginaSiguiente.isHidden = false
    }
    func mostrarAnterior() {
        self.paginaAnterior.isHidden = false
    }
    
    
    //MARK: Table Delegate
    //Función delegada que prepara el segue hacia el detalle
    func detalleCelda(_ sender: TablaViewController) {
        performSegue(withIdentifier: "detallesSegue", sender: sender.repositorios?[(repoList.indexPath(for: sender.celda!)?.row)!])
    }
    


    
    
}

