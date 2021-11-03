//
//  SpotifyManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 02.11.2021.
//

import Foundation

class SpotifyManager: NSObject, SPTAppRemoteDelegate, SPTSessionManagerDelegate {
    private let spotifyClientID = "4cdd37c0271b4b4a93456b17b1b5e253"
    private let spotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!

    lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
    }()

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()

    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: spotifyClientID, redirectURL: spotifyRedirectURL)

        configuration.playURI = ""

        return configuration
    }()

    // MARK: - Public

    func connect() {
        sessionManager.initiateSession(with: [.playlistModifyPrivate, .playlistReadPrivate], options: .clientOnly)
    }

    // MARK: - SPTAppRemoteDelegate
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("appRemoteDidEstablishConnection")
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
        appRemote.connectionParameters.accessToken = session.accessToken
        appRemote.connect()
    }
}
