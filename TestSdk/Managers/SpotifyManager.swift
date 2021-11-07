//
//  SpotifyManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 02.11.2021.
//

import Foundation

enum SpotifyConstants: String {
    case spotifyClientID = "4cdd37c0271b4b4a93456b17b1b5e253"
    case spotifyClientSecret = "10e1d6a2b39e4f67a828d490b2ec25b9"
    case spotifyRedirectUrl = "spotify-ios-quick-start://spotify-login-callback"
}

class SpotifyManager: NSObject, SPTAppRemoteDelegate, SPTSessionManagerDelegate {
    private let spotifyRedirectURL = URL(string: SpotifyConstants.spotifyRedirectUrl.rawValue)!

    var spotifyCodeCallBack: ((String) -> Void)?

    lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
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
        sessionManager.initiateSession(with: [.streaming, .userReadPlaybackState, .playlistReadPrivate, .userLibraryRead], options: .clientOnly)
    }

    func swapAccessToken(_ code: String) {
        spotifyCodeCallBack?(code)
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
        appRemote.connectionParameters.accessToken = session.accessToken
        appRemote.connect()
    }
}
