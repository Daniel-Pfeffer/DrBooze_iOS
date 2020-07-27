//
//  LoginController.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 19.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation
import Moya
import SwiftUI

class LoginController {

    let provider = MoyaProvider<MyService>()
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    static let instance = LoginController()

    private init() {

    }

    func login(_ username: String, withPassword password: String, binding: Binding<Bool>) {
        provider.request(.login(username: username, password: password)) { result in
            switch result {
            case let .success(moyaResponse):
                guard let resp = moyaResponse as? Moya.Response else {
                    return
                }
                if resp.hasStatusCode(.Ok) {
                    let data = resp.data
                    let encodedData = try? self.decoder.decode(LoginStruct.self, from: data)
                    Shared.instance.bearer = encodedData!.token
                    self.getUser(binding: binding)
                }
            case .failure(_):
                print("Fuck me")
            }
        }
    }

    func register(_ username: String, withMail mail: String, withPassword password: String) {
        print("Register tried with \(username)/\(mail)/\(password)")
    }

    private func getUser(binding: Binding<Bool>) {
        let authPlugin = AccessTokenPlugin {
            Shared.instance.bearer
        }
        let provider = MoyaProvider<MyService>(plugins: [authPlugin])

        provider.request(.getUser) { result in
            switch result {
            case let .success(moyaResponse):
                guard let resp = moyaResponse as? Moya.Response else {
                    return
                }
                if resp.hasStatusCode(.Ok) {
                    let data = resp.data
                    let encodedData = try? self.decoder.decode(User.self, from: data)
                    encodedData!.calculateGKW()
                    Shared.instance.user = encodedData!
                    binding.wrappedValue = true
                }
            case .failure(_):
                print("Fuck me")
            }
        }
    }
}
