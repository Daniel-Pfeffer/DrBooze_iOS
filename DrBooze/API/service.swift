//
//  service.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 19.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation
import Moya

enum MyService {
    case register(username: String, email: String, password: String)
    case login(username: String, password: String)
    case getUser
    case setDetails(gender: String, birthday: Int, height: Double, weight: Double, firstName: String?, lastName: String?)
    case getAlcohols(type: String)
    case getFavourites(type: String)
    case addFavourite(id: Int)
    case removeFavourite(id: Int)
    case getAllDrink
    case getDrinks(count: Int)
    case removeDrink(id: Int)
    case addDrink(drink: Drink)
    case getPersonalAlcohols(type: String)
    case addPersonalAlcohol(type: String, name: String, category: String, percentage: Double, amount: Double)
    case removePersonalAlcohol(id: Int)
}

extension MyService: TargetType {
    var baseURL: URL {
        URL(string: "http://vm102.htl-leonding.ac.at:8080/booze/")!
    }

    var path: String {
        switch self {
        case .register:
            return "auth/register"
        case .login:
            return "auth/login"
        case .getUser:
            return "manage/user"
        case .setDetails:
            return "manage/details"
        case .getAlcohols(type: let type):
            return "manage/alcohols/\(type)"
        case .getFavourites(type: let type):
            return "manage/favourites/\(type)"
        case .addFavourite(id: let id),
             .removeFavourite(id: let id):
            return "manage/favourites/\(id)"
        case .getAllDrink:
            return "manage/drinks"
        case .getDrinks(count: let count):
            return "manage/drinks/\(count)"
        case .removeDrink(id: let id):
            return "manage/drinks/\(id)"
        case .addDrink:
            return "manage/drinks"
        case .getPersonalAlcohols(type: let type):
            return "manage/personal-alcohols/\(type)"
        case .addPersonalAlcohol:
            return "manage/personal-alcohols"
        case .removePersonalAlcohol(id: let id):
            return "manage/personal-alcohols/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .register,
             .login,
             .setDetails,
             .addFavourite,
             .addDrink,
             .addPersonalAlcohol:
            return .post
        case .getAlcohols,
             .getAllDrink,
             .getDrinks,
             .getFavourites,
             .getPersonalAlcohols,
             .getUser:
            return .get
        case .removeDrink,
             .removeFavourite,
             .removePersonalAlcohol:
            return .delete
        }
    }

    var sampleData: Data {
        "Nope".utf8Encoded
    }

    var task: Task {
        switch self {
        case .getUser,
             .getPersonalAlcohols,
             .getFavourites,
             .getDrinks,
             .getAllDrink,
             .getAlcohols,
             .addFavourite,
             .removeFavourite,
             .removeDrink,
             .removePersonalAlcohol:
            return .requestPlain
        case .register(let username, let email, let password):
            return .requestParameters(parameters: ["email": email, "username": username, "password": password], encoding: JSONEncoding.default)
        case .login(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
        case .setDetails(let gender, let birthday, let height, let weight, let firstName, let lastName):
            var params: [String: Any] = ["gender": gender, "birthday": birthday, "height": height, "weight": weight]
            if let firstName = firstName {
                params["firstName"] = firstName
            }
            if let lastName = lastName {
                params["lastName"] = lastName
            }
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .addDrink(drink: let drink):
            return .requestParameters(parameters: ["alcoholId": drink.alcohol.id, "drankDate": drink.drankDate, "longitude": drink.longitude, "latitude": drink.latitude], encoding: JSONEncoding.default)
        case .addPersonalAlcohol(type: let type, name: let name, category: let category, percentage: let percentage, amount: let amount):
            return .requestParameters(parameters: ["type": type, "name": name, "category": category, "percentage": percentage, "amount": amount], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json", "Accept": "application/json"]
    }
}

extension MyService: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        switch self {
        case .login,
             .register:
            return .none
        case .setDetails,
             .addFavourite,
             .addDrink,
             .addPersonalAlcohol,
             .getAlcohols,
             .getAllDrink,
             .getDrinks,
             .getFavourites,
             .getPersonalAlcohols,
             .getUser,
             .removeDrink,
             .removeFavourite,
             .removePersonalAlcohol:
            return .bearer
        }
    }
}