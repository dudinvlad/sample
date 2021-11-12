//
//  SoundtrackService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 11.11.2021.
//

import Foundation

typealias SoundtrackResponseBlock = ([AMSoundtrack]?, String?) -> Void

protocol SoundtrackService {
    func fetchDefaultsSoundtracks(_ completion: @escaping SoundtrackResponseBlock)
}
