//
//  ConstructAuthilloLoginUrl.swift
//  ios-integration-demo
//
//  Created by James Grom on 2/26/23.
//

import Foundation
import CryptoKit
import UIKit


public class Authillo:NSObject{
    var clientId:String;
    var codeChallenge:String?;
//    var backendURL:String = "http:localhost:5001"
    var backendURL:String = "https://breezy-boats-sleep-73-63-183-230.loca.lt"
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
    public func AuthorizeUser(scopes:[Scope],maxAge:Int = 3600,state:String?, redirectURI: String? ){
        let formattedScopes = scopes.reduce("openid") { partialResult, scope in
            return partialResult + " \(scope)"
        }
        let resolvedCodeChallenge: String = self.codeChallenge ?? "wqLt_MECt2BMAclCfXOnVfXDTffgA594Ql0m6GwEv0Q";
        if(self.codeChallenge == nil){
            print("WARNING - code challenge missing, you should make sure to generate & store a code_verifier on your backend for your user then generate a hash of the code_verifier using SHA256 and share the hash with your client here as code_challenge")
        }
        let resolvedRedirectUri = redirectURI ?? { if(Bundle.main.bundleIdentifier != nil) {return "\(Bundle.main.bundleIdentifier!)://" }else {return "bundleidentifierwasnil" }}()
        var urlString = "https://authillo.com/authorize?response_type=code&client_id=\(self.clientId)&scope=\(formattedScopes)&state=\(state ?? "undefined")&redirect_uri=\(resolvedRedirectUri)&max_age=\(maxAge)&code_challenge=\(resolvedCodeChallenge)&code_challenge_method=S256"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(urlString)
        guard let authillourl = URL( string: urlString) else { print("ERROR - failed to generate authilloauthorize URL")
            return
        }
        UIApplication.shared.open(authillourl)
        
    }
    func HandleReturnFromAuthorization(authorizationCode:String,state:String, uiCallback: (() -> Void)?){
        print("handleReturnFromAuthorization function called " ,authorizationCode,state);
        guard let url = URL(string: "\(self.backendURL)/codeResponse?code=\(authorizationCode)&state=\(state)&makeUserInfoReq=true") else { return }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        let datatask = URLSession.shared.dataTask(with: request) { dat, resp, err in
            if err == nil && dat != nil {
                do {
                    let response = try JSONSerialization.jsonObject(with: dat!, options: .fragmentsAllowed)
                    print(response)
                } catch {
                    print("error parsing data")
                    print(dat!)
                }
            }else{
                print("error calling coderesponse")
            }
        
        }
        datatask.resume()
        
    }
    func GetCodeChallenge(uiCallback: ((String) -> Void)?) {
        guard let url = URL(string: "\(self.backendURL)/codechallenge") else { return }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        let datatask = URLSession.shared.dataTask(with: request) { dat, resp, err in
            if err == nil && dat != nil {
                do {
                    let codeChallenge = try JSONSerialization.jsonObject(with: dat!, options: .fragmentsAllowed)
                    print(codeChallenge)
                    self.codeChallenge = codeChallenge as? String
                    
                    uiCallback?(self.codeChallenge ?? "")
                    
                } catch {
                    print("error parsing data")
                    print(dat!)
                }

            }else{
                print("errorrr")
            }
        }
        datatask.resume()
        
    }
}

