//
//  ConstructAuthilloLoginUrl.swift
//  ios-integration-demo
//
//  Created by James Grom on 2/26/23.
//

import Foundation


public enum Scopes {
    case name,age,face,selfie,idphoto,email,phone,license,sex,birthdate
}
public class Authillo:NSObject{
    var clientId:String
    /// Initializes the Authillo class with the necessary parameters
    /// - Parameter clientId: The unique id representing your application. Your clientId can be found at the bottom of your platform's authillo dashboard in the config tab.
    init( clientId:String ) {
        self.clientId = clientId
    }
    /// Redirects user to login using authillo
    /// - Parameters:
    ///   - scopes: The user information requested from the user. All requested information/scopes must be included in your platform's requirements in your platform configuration.
    ///   - maxAge: How long the token should be valid for in seconds.
    ///   - codeChallenge: The hashed version of the codeVerifier. The codeVerifier is a secret random string that should be stored on your backend server to then be used to authorize your backend server's token request.
    ///   - redirectURI: The url that the user will be redirected back to. Must exactly match one of the redirect url's you entered in your platform configuration. This value defaults to your app's bundle identifier suffixed with "://"
    public func AuthorizeUser(scopes:[Scopes],maxAge:Int,codeChallenge:String? = nil, redirectURI: String? = nil){
        
    }
//    public func LoginWithAuthillo(){
////
//    }
}

