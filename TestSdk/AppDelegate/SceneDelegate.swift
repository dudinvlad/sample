//
//  SceneDelegate.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 20.10.2021.
//

import UIKit
import Macaroni

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    @Injected var welcomeAssembly: WelcomeModule.ModuleAssemblying!
    @Injected var spotifyManager: SpotifyManager!

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        Container.policy = .singleton(RestContainerFactory().build())
        window = UIWindow(windowScene: windowScene)
        let welcomeViewController = welcomeAssembly.assemble()
        let navigationController = UINavigationController(rootViewController: welcomeViewController)
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.overrideUserInterfaceStyle = .dark
        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }

        spotifyManager.sessionManager.application(UIApplication.shared, open: url, options: [:])

//        let parameters = spotifyManager.appRemote.authorizationParameters(from: url)
//
//        if let exchangeCode = parameters?["code"] {
//            spotifyManager.swapAccessToken(exchangeCode)
//        } else if let error = parameters?[SPTAppRemoteErrorDescriptionKey] {
//            window?.rootViewController?.showAlert(with: "Please re-login into your spotify account and try again", title: "Ops!")
//        }
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

