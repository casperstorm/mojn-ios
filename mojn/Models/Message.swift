//
//  Message.swift
//  mojn
//
//  Created by Casper Rogild Storm on 26/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import MessageKit
import SwiftyJSON

struct Message: MessageType {
    let messageId: String
    let sender: Sender
    let sentDate: Date
    let kind: MessageKind
    
    private init(kind: MessageKind, sender: Sender, messageId: String, date: Date) {
        self.messageId = messageId
        self.sender = sender
        self.sentDate = date
        self.kind = kind
    }
    
    
    init?(json: JSON) {
        guard let messageId = json["id"].string else { return nil }
        guard let body = json["body"].string else { return nil }
        guard let from = json["from"].string else { return nil }
        guard let dateString = json["dateSent"].string else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        

        let sender: Sender = Sender(id: from, displayName: from)
        self.init(kind: .text(body), sender: sender, messageId: messageId, date: date)
    }
}
