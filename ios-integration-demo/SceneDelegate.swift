//
//  SceneDelegate.swift
//  ios-integration-demo
//
//  Created by James Grom on 2/25/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for elem in URLContexts {
            let url = elem.url
            print("user returned from authorization with url = ",url)
            guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
            let AuthorizationCode = urlComponents.queryItems?.first(where: {$0.name == "code"})?.value
            let state = urlComponents.queryItems?.first(where: {$0.name == "state"})?.value
            
            //todo: if u can make this function called from the MainViewController, then we can pass a uiCallback. As the callback is defined within MainVC, then we can either unhide a button for RequestUserInfo, or if that's not implemented, we can immediately occupy the view with the userInfo.
            //In the latter case, we'd have to add parameters into uiCallback so that userInfo can be passed to MainVC. For example, see the uiCallback for GetCodeChallenge; that uiCallback has a String parameter, and then it's function body is set in MainVC.
            //I've left you a label for userInfo that should be okay to receive a json.
            AuthilloInstance.HandleReturnFromAuthorization(authorizationCode: AuthorizationCode ?? "", state: state ?? "", uiCallback: nil)
            
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

