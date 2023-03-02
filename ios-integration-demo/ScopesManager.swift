//
//  ActiveScopesManager.swift
//  ios-integration-demo
//
//  Created by Daniel Ziems on 2/28/23.
//

import Foundation


public enum Scope {
    case name,
         age,
         face,
         selfie,
         idphoto,
         email,
         phone,
         license,
         sex,
         birthdate
}

public class ScopesManager {
    
    var scopes: Dictionary<Scope, Bool>
    
    init() {
        scopes =
        [
            .name : false,
            .age : false,
            .face : false,
            .selfie : false,
            .idphoto : false,
            .email : false,
            .phone : false,
            .license : false,
            .sex : false,
            .birthdate : false,
        ]
    }
    
    public func toggleScope(scope: Scope, newValue: Bool) {
        scopes[scope] = newValue;
    }
    
    func getActiveScopes() -> [Scope] {
        var activeScopes: [Scope] = [];
        for (scope, isActiveVal) in scopes {
            if isActiveVal {
                activeScopes.append(scope)
            }
        }
        
        return activeScopes
    }
}

