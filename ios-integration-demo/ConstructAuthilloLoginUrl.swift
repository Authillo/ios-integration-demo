//
//  ConstructAuthilloLoginUrl.swift
//  ios-integration-demo
//
//  Created by James Grom on 2/26/23.
//

import Foundation
import CryptoKit
import UIKit


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
    ///   - state: A string that will be included in the query parameters of the user when redirected back. This can be used to store some state relevant to the user between redirects (ex: the page they were on before logging in).
    public func AuthorizeUser(scopes:[Scopes],maxAge:Int = 3600,state:String?,codeChallenge:String?, redirectURI: String? ){
        let formattedScopes = scopes.reduce("openid") { partialResult, scope in
            return partialResult + " \(scope)"
        }
        var resolvedCodeChallenge: String = SHA256.hash(data: Data("UNSAFECODEVERIFIER".utf8)).compactMap { String(format: "%02x", $0)}.joined()
        if(codeChallenge == nil){
            print("WARNING - code challenge missing, you should make sure to generate & store a code_verifier on your backend for your user then generate a hash of the code_verifier using SHA256 and share the hash with your client here as code_challenge")
        }else{
            resolvedCodeChallenge = codeChallenge ?? resolvedCodeChallenge
        }
        let resolvedRedirectUri = redirectURI ?? { if(Bundle.main.bundleIdentifier != nil) {return "\(Bundle.main.bundleIdentifier!)://" }else {return "bundleidentifierwasnil" }}()
        var urlString = "https://authillo.com/authorize?response_type=code&client_id=\(self.clientId)&scope=\(formattedScopes)&state=\(state ?? "undefined")&redirect_uri=\(resolvedRedirectUri)&max_age=\(maxAge)&code_challenge=\(resolvedCodeChallenge)&code_challenge_method=S256"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let authillourl = URL( string: urlString) else { print("ERROR - failed to generate authilloauthorize URL")
            return
        }
        UIApplication.shared.open(authillourl)
        
    }
    func HandleReturnFromAuthorization(url:URL){
        print("user returned from authorization with url = ",url)
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        let AuthorizationCode = urlComponents.queryItems?.first(where: {$0.name == "code"})?.value
        let state = urlComponents.queryItems?.first(where: {$0.name == "state"})?.value
        print("AuthorizationCode \(AuthorizationCode ?? "")")
        print("state \(state ?? "")")
        
    }
}

