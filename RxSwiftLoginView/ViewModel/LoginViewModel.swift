//
//  LoginViewModel.swift
//  RxSwiftLoginView
//
//  Created by Sujeet.Kumar on 19/08/19.
//  Copyright © 2019 Cuddle. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
    
    var username = BehaviorSubject(value: "")//Variable<String>("")
    var password = BehaviorSubject(value: "")//Variable<String>("")
    
//    var test = ReplaySubject<String>
    
    var isValid : Observable <Bool> {
        return Observable.combineLatest(username.asObservable(), password.asObservable()) {
            usernameString, passwordString in
            usernameString.count >= 4 &&
            passwordString.count >= 4
        }
    }
  
}

