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
    var completeArray: Array<Alcohol> = []

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
                    self.provider!.request(.getPersonalAlcohols(type: type.rawValue)) { result in
                        switch result {
                        case let .success(moyaResponse):
                            guard let resp = moyaResponse as? Moya.Response else {
                                return
                            }
                            if resp.hasStatusCode(.Ok) {
                                self.handleRequest(result: resp, isPersonal: true)
                                // load personal Alcohol
                                self.provider!.request(.getFavourites(type: type.rawValue)) { result in
                                    switch result {
                                    case let .success(moyaResponse):
                                        guard let resp = moyaResponse as? Moya.Response else {
                                            return
                                        }
                                        if resp.hasStatusCode(.Ok) {
                                            self.handleRequest(result: resp, isFavourite: true)
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

    private func handleRequest(result: Moya.Response, isFavourite isFavouriteRequest: Bool = false, isPersonal isPersonalRequest: Bool = false) {
        let data = result.data
        let encodedData = try? self.decoder.decode(Array<Alcohol>.self, from: data)
        for var alcohol in encodedData! {
            alcohol.checkCategory()
            if isFavouriteRequest {
                alcohol.isFavourite()
                if completeArray.contains(where: { $0.id == alcohol.id && $0.validatePersonal() }) {
                    alcohol.isPersonal = true
                }

            }
            if isPersonalRequest {
                alcohol.isPersonal = true
            }
            completeArray.append(alcohol)
        }
    }

    private func doTheData(binding: Binding<Array<AlcoholListStruct>>) {
        // sort array by category and name
        completeArray = completeArray.sorted {
            if $0.category != $1.category {
                return $0.category! < $1.category!
            } else {
                return $0.name < $1.name
            }
        }

        completeArray.forEach { alcohol in
            if binding.wrappedValue.count == 0 {
                var a: Array<Alcohol> = []
                a.append(alcohol)
                binding.wrappedValue.append(AlcoholListStruct(category: alcohol.category!, alcohol: a))
            } else {
                var bool = false
                var counter = 0
                for alcoholList in binding.wrappedValue {
                    if alcoholList.category == alcohol.category {
                        binding.wrappedValue[counter].alcohol.append(alcohol)
                        bool = true
                    }
                    counter += 1
                }
                if !bool {
                    var a: Array<Alcohol> = []
                    a.append(alcohol)
                    if alcohol.category == "Regular" {
                        binding.wrappedValue.insert(AlcoholListStruct(category: alcohol.category!, alcohol: a), at: 1)
                    } else if alcohol.category == "Favourite" {
                        binding.wrappedValue.insert(AlcoholListStruct(category: alcohol.category!, alcohol: a), at: 0)
                    } else {
                        binding.wrappedValue.append(AlcoholListStruct(category: alcohol.category!, alcohol: a))
                    }
                }
            }
        }
    }

    func addNewAlcohol() {
    }

    func addToFavourites(_ id: Int) {
        self.provider!.request(.addFavourite(id: id)) { result in
            switch result {
            case let .success(moyaResponse):
                guard let resp = moyaResponse as? Moya.Response else {
                    return
                }
                if resp.hasStatusCode(.Ok) {

                }

            case .failure(_):
                debugPrint("Request failed")
            }
        }
    }

    func removeFromFavourites(_ id: Int) {
        self.provider!.request(.removeFavourite(id: id)) { result in
            switch result {
            case let .success(moyaResponse):
                guard let resp = moyaResponse as? Moya.Response else {
                    return
                }
                if resp.hasStatusCode(.Ok) {

                }

            case .failure(_):
                debugPrint("Request failed")
            }
        }
    }

    func deleteAlcohol(_ id: Int) {
        self.provider!.request(.removePersonalAlcohol(id: id)) { result in
            switch result {
            case let .success(moyaResponse):
                guard let resp = moyaResponse as? Moya.Response else {
                    return
                }
                if resp.hasStatusCode(.Ok) {

                }

            case .failure(_):
                debugPrint("Request failed")
            }
        }
    }
}