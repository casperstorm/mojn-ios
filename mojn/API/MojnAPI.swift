//
//  API.swift
//  mojn
//
//  Created by Casper Rogild Storm on 21/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

class MojnAPI {
    enum APIRoutes {
        case base
        case balance(_ sid: String)
        case numbers(_ sid: String)
        case messages(_ sid: String, query: String?)
        
        func endpoint() -> String {
            switch self {
            case .base:
                return "https://api.twilio.com/2010-04-01/"
            case .balance(let sid):
                return "/Accounts/\(sid)/Balance.json"
            case .numbers(let sid):
                return "/Accounts/\(sid)/IncomingPhoneNumbers.json"
            case .messages(let sid, let query):
                return "/Accounts/\(sid)/Messages.json\(query ?? "")"
            }
        }
    }
    
    static let sharedInstance = MojnAPI()
    private let service = Service(baseURL: APIRoutes.base.endpoint(), standardTransformers: [])
    private var token: String? {
        didSet {
            service.invalidateConfiguration()
            service.wipeResources()
        }
    }
    
    private init() {
        SiestaLog.Category.enabled = [.network, .pipeline]
        let SwiftyJSONTransformer =
            ResponseContentTransformer
                { JSON($0.content as AnyObject) }
        
        service.configure("**") {
            guard let token = self.token else { return }
            $0.headers["Authorization"] = "Basic " + token
            $0.headers["Accept"] = "application/json"
            $0.pipeline[.parsing].add(
                SwiftyJSONTransformer,
                contentTypes: ["*/json"])
        }
        
        service.configureTransformer(APIRoutes.numbers("*").endpoint()) {
            return ($0.content as JSON)["incoming_phone_numbers"].arrayValue.map({ json in
                return Number(json)
            })
        }
    }
}

// MARK: - sid
extension MojnAPI {
    func sid() -> String {
        guard let sid = Keychain(identifier: .credentials).get(.sid) else {
            fatalError("No SID found in Keychain.")
        }
        return sid
    }
}

// MARK: - Twilio
extension MojnAPI {
    func balance() -> Resource {
        let sid = self.sid()
        return service.resource(APIRoutes.balance(sid).endpoint())
    }
}


extension MojnAPI {
    func numbers() -> Resource {
        let sid = self.sid()
        return service.resource(APIRoutes.numbers(sid).endpoint())
    }
}

extension MojnAPI {
    func messages(from: String) -> Resource {
        let sid = self.sid()
        return service.resource(APIRoutes.messages(sid, query: "?From=\(from)").endpoint())
    }
}

extension MojnAPI {
    func login(sid: String, token: String) {
        guard let token = base64TokenString(sid: sid, token: token) else { return }
        self.token = token
    }
    
    func base64TokenString(sid: String, token: String) -> String? {
        let string = String(format: "%@:%@", sid, token)
        let data = string.data(using: String.Encoding.utf8)
        return data?.base64EncodedString()
    }
}

