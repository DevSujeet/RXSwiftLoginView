//
//  ViewController.swift
//  RxSwiftLoginView
//
//  Created by Sujeet.Kumar on 19/08/19.
//  Copyright © 2019 Cuddle. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var validationsLabel: UILabel!
    

    var loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Bind UI textFields to properties in ViewModel
        ///your traditional UI elements to Rx components, created a computed property,
        ///and made it an Observable. Later, you subscribed to events emitted by the
        ///computed property to reflect the state of validations in the main View.
        _ = usernameTextField.rx.text
            .map { $0 ?? "" }   //to ensure that the text is non nil
            .bind(to: loginViewModel.username)//pass that through to bind the returned value to the ViewModel's variable as desired by making use of the bindTo operator:
            .disposed(by: disposeBag)
        
        _ = passwordTextField
            .rx
            .text
            .map {$0 ?? "" }
            .bind(to: loginViewModel.password)
            .disposed(by: disposeBag)

        //1.way--- bind the validation output to the button eanbled property
//        _ = loginViewModel.isValid.bind(to: loginButton.rx.isEnabled)
        
        //2.way---- allows you to subscribe to any change in the isValid property's value.
        //We can subscribe to three different types of event emitted by an Observable: next, error, and completed.
        _ = loginViewModel.isValid.subscribe(onNext: {[unowned self] isValid in
            self.validationsLabel.text = isValid ? "Enabled" : "Disabled"
            self.validationsLabel.textColor = isValid ? .green : .red
            
            self.loginButton.isEnabled = isValid ? true : false
            self.loginButton.backgroundColor = isValid ? UIColor.orange :
                UIColor.lightGray
            
        })
    }


}

