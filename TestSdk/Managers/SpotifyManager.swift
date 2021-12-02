//
//  SpotifyManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 02.11.2021.
//

import Foundation
import JWTDecode

enum SpotifyConstants: String {
    case spotifyClientID = "f590b8702f064c3f9cf7cf892ef6586a"
    case spotifyClientSecret = "ca335889875c4554b7be7f45af112e2a"
    case spotifyRedirectUrl = "http://com.app.ringalarmspotify/callback"//"spotify-ios-quick-start://spotify-login-callback"
}

class SpotifyManager: NSObject, SPTAppRemoteDelegate, SPTSessionManagerDelegate {
    private let spotifyRedirectURL = URL(string: SpotifyConstants.spotifyRedirectUrl.rawValue)!

    var spotifyCodeCallBack: ((String) -> Void)?

    lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        manager.alwaysShowAuthorizationDialog = false
        manager.delegate = self
        return manager
    }()

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()

    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: SpotifyConstants.spotifyClientID.rawValue, redirectURL: spotifyRedirectURL)

        configuration.playURI = ""

        return configuration
    }()

    // MARK: - Public

    func connect(_ completion: @escaping (String) -> Void) {
        self.spotifyCodeCallBack = completion
            sessionManager.initiateSession(with: [.playlistReadPrivate, .userLibraryRead], options: .clientOnly)
    }

    func swapAccessToken(_ code: String) {
    }

    // MARK: - SPTAppRemoteDelegate
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print(appRemote)
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("didFailConnectionAttemptWithError: \(error?.localizedDescription ?? "")")
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("Error here: \(error?.localizedDescription ?? "")")
    }

    // MARK: - SPTSessionManagerDelegate

    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("session manager failed: \(error.localizedDescription)")
    }

    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("session manager renew: \(session.accessToken)")
    }

    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        DispatchQueue.main.async {
            self.spotifyCodeCallBack?(session.accessToken)
        }
    }
}
