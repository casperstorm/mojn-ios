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
        case messages(_ sid: String)
        
        func endpoint() -> String {
            switch self {
            case .base:
                return "https://api.twilio.com"
            case .balance(let sid):
                return "/2010-04-01/Accounts/\(sid)/Balance.json"
            case .numbers(let sid):
                return "/2010-04-01/Accounts/\(sid)/IncomingPhoneNumbers.json"
            case .messages(let sid):
                return "/2010-04-01/Accounts/\(sid)/Messages.json"
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
        setupServiceConfigurations()
        setupServiceTransformers()
    }
}

extension MojnAPI {
    func setupServiceConfigurations() {
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
    }
    
    func setupServiceTransformers() {
        service.configureTransformer(APIRoutes.numbers("*").endpoint()) {
            return ($0.content as JSON)["incoming_phone_numbers"].arrayValue.map({ json in
                return Number(json)
            })
        }
        
        service.configureTransformer(APIRoutes.messages("*").endpoint()) {
            return ($0.content as JSON)["messages"].arrayValue.map({ json in
                return Message(json)
            })
        }
    }
}

extension MojnAPI {
    func sid() -> String {
        guard let sid = Keychain(identifier: .credentials).get(.sid) else {
            fatalError("No SID found in Keychain.")
        }
        return sid
    }
}

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
    // TODO:
    // Pagination
    
    func messages(size: Int = 50) -> Resource {
        return messages(from: nil, to: nil, size: size)
    }
    
    func messages(from: String) -> Resource {
        return messages(from: from, to: nil, size: 50)
    }
    
    func messages(from: String, to: String) -> Resource {
        return messages(from: from, to: to, size: 50)
    }
    
    fileprivate func messages(from: String?, to: String?, size: Int) -> Resource {
        let sid = self.sid()
        return  service
            .resource(APIRoutes.messages(sid).endpoint())
            .withParam("From", from)
            .withParam("To", to)
            .withParam("PageSize", "\(size)")
    }
    
    func message(text: String, from: String, to: String) -> Request {
        let sid = self.sid()
        return service.resource(APIRoutes.messages(sid).endpoint()).request(.post, urlEncoded: ["From": from, "To": to, "Body": text])
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

