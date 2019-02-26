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
    static let sharedInstance = MojnAPI()
    
    private let service = Service(
        baseURL: "http://localhost:5000",
        standardTransformers: [])
    
    private var token: String? {
        didSet {
            service.invalidateConfiguration()  // So that future requests for existing resources pick up config change
            service.wipeResources()            // Scrub all unauthenticated data
        }
    }
    
    private init() {
        SiestaLog.Category.enabled = [.network, .pipeline]
        
        service.configure("**") {
//            guard let token = self.token else { return }
//            $0.headers["Authorization"] = "Bearer " + token
            $0.headers["Authorization"] = "Bearer " + "88a1473f415361f8a1d9bc83aa2808f1c3712707"
            $0.headers["Accept"] = "application/json"
        }
        
        let jsonDecoder = JSONDecoder()
        service.configureTransformer("/user") {
            try jsonDecoder.decode(User.self, from: $0.content)
        }
        
        service.configureTransformer("/pseudos") {
            try jsonDecoder.decode([Pseudo].self, from: $0.content)
        }
        
        service.configureTransformer("/login") {
            try jsonDecoder.decode([String: String].self, from: $0.content)
        }
        
        service.configureTransformer("/message") {
            try JSON(data: $0.content).arrayValue.map({ (json) -> Message? in
                return Message(json: json)
            })
        }
    }
}

// MARK: - User
extension MojnAPI {
    func user() -> Resource {
        return service.resource("/user")
    }
}

// MARK: - Pseudo
extension MojnAPI {
    func pseudos() -> Resource {
        return service.resource("/pseudos")
    }
}

// MARK: - Messages
extension MojnAPI {
    func message() -> Resource {
        return service.resource("/message")
    }
}

// MARK: - Auth
extension MojnAPI {
    func login(username: String, password: String) -> Request {
        return service
            .resource("/login")
            .request(.post, json: ["username": username, "password": password])
            .onSuccess({ [weak self] response in
                guard let self = self else { return }
                guard let dictionary: [String: String] = response.typedContent() else { return }
                guard let token = dictionary["sessionToken"] else { return }
                
                self.token = token
            })
    }
}
