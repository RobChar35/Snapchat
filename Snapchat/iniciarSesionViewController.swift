//
//  ViewController.swift
//  Snapchat
//
//  Created by Robert Charca on 31/05/23.
//

import UIKit
import FirebaseAuth

import FirebaseCore
import GoogleSignIn

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        // Do any additional setup after loading the view.
    }

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
            } else {
                print("Inicio de sesion exitoso")
            }
        }
    }
    
    @IBAction func goggleiOSTapped(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) {[unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                print("Intentando Iniciar Sesión con correo electrónico y contraseña")
                if let error = error {
                    print("Se presentó el siguiente error: \(error)")
                } else {
                    print("Inicio de sesión exitoso")
                }
            }
        }
    }
    
    
}

