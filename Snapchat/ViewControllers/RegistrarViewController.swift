//
//  RegistrarViewController.swift
//  Snapchat
//
//  Created by Robert Charca on 9/06/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class RegistrarViewController: UIViewController {

    @IBOutlet weak var nuevoUsuarioTextField: UITextField!
    @IBOutlet weak var nuevoPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrarUsuarioTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: nuevoUsuarioTextField.text!, password: nuevoPasswordTextField.text!) {
            (user, error) in
            print("Creando nuevo usuario...")
            
            if error != nil {
                print("Error al crear usuario: \(error)")
                
                let alert = UIAlertController(title: "Error de creacion", message: "Error al momento de crear un usuario", preferredStyle: .alert)
                
                let btnCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: {(UIAlertAction) in })
                
                alert.addAction(btnCancelar)
                self.present(alert, animated: true, completion: nil)
            } else {
                print("El nuevo usuario fue creado exitosamente")
                
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                
                let alert = UIAlertController(title: "Creacion de nuevo usuario", message: "El usuario \(self.nuevoUsuarioTextField.text!) fue creado correctamente", preferredStyle: .alert)
                
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: {
                    (UIAlertAction) in
                    self.performSegue(withIdentifier: "ingresarNuevoUsuarioSegue", sender: nil)
                })
                
                alert.addAction(btnOK)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
