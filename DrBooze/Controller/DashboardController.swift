//
//  DashboardController.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 16.07.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation
import Moya
import SwiftUI

class DashboardController {

    var provider: MoyaProvider<MyService>? = nil
    var authPlugin: AccessTokenPlugin? = nil
    var decoder = JSONDecoder()
    let encoder = JSONEncoder()
    static let instance = DashboardController()
    var completeArray: Set<Alcohol> = []

    private init() {
        let token = Shared.instance.bearer

        self.authPlugin = AccessTokenPlugin {
            token
        }
        self.provider = MoyaProvider<MyService>(plugins: [authPlugin!])
    }

    // load general Alcohol
    func loadAlcohol(type: AlcoholType, binding: Binding<Array<AlcoholListStruct>>) {
        self.completeArray = []

        provider!.request(.getAlcohols(type: type.rawValue)) { result in
            switch result {
            case let .success(moyaResponse):
                guard let resp = moyaResponse as? Moya.Response else {
                    return
                }
                if resp.hasStatusCode(.Ok) {
                    self.handleRequest(result: resp)
                    // load favourite Alcohol
                    self.provider!.request(.getFavourites(type: type.rawValue)) { result in
                        switch result {
                        case let .success(moyaResponse):
                            guard let resp = moyaResponse as? Moya.Response else {
                                return
                            }
                            if resp.hasStatusCode(.Ok) {
                                self.handleRequest(result: resp)
                                // load personal Alcohol
                                self.provider!.request(.getPersonalAlcohols(type: type.rawValue)) { result in
                                    switch result {
                                    case let .success(moyaResponse):
                                        guard let resp = moyaResponse as? Moya.Response else {
                                            return
                                        }
                                        if resp.hasStatusCode(.Ok) {
                                            self.handleRequest(result: resp)
                                            self.doTheData(binding: binding)
                                        }

                                    case .failure(_):
                                        debugPrint("Request failed")
                                    }
                                }
                            }
                        case .failure(_):
                            debugPrint("Request failed")
                        }
                    }
                }
            case .failure(_):
                debugPrint("Request failed")
            }
        }
    }

    private func handleRequest(result: Moya.Response) {
        let data = result.data
        let encodedData = try? self.decoder.decode(Array<Alcohol>.self, from: data)
        for var alcohol in encodedData! {
            alcohol.checkCategory()
            completeArray.insert(alcohol)
        }
    }

    private func doTheData(binding: Binding<Array<AlcoholListStruct>>) {
        completeArray.forEach { alcohol in
            if binding.wrappedValue.count == 0 {
                var a: Array<Alcohol> = []
                a.append(alcohol)
                binding.wrappedValue.append(AlcoholListStruct(category: alcohol.category!, alcohol: a))
            } else {
                var bool = false
                var counter = 0
                for var alcoholList in binding.wrappedValue {
                    if alcoholList.category == alcohol.category {
                        binding.wrappedValue[counter].alcohol.append(alcohol)
                        bool = true
                    }
                    counter += 1
                }
                if !bool {
                    var a: Array<Alcohol> = []
                    a.append(alcohol)
                    binding.wrappedValue.append(AlcoholListStruct(category: alcohol.category!, alcohol: a))
                }
            }
        }
    }
}

/*

*/