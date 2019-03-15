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

enum MessageStatus: String {
    case queued, failed, sent, delivered, undelivered, received
}

struct Message: MessageType {
    let messageId: String
    let sender: Sender
    let sentDate: Date
    let kind: MessageKind
    let recipient: String
    let status: MessageStatus
    
    private init(kind: MessageKind,
                 sender: Sender,
                 recipient: String,
                 messageId: String,
                 date: Date,
                 status: MessageStatus) {
        self.messageId = messageId
        self.sender = sender
        self.sentDate = date
        self.kind = kind
        self.recipient = recipient
        self.status = status
    }
    
    
    init?(_ json: JSON) {
        guard let messageId = json["sid"].string else { return nil }
        guard let body = json["body"].string else { return nil }
        guard let from = json["from"].string else { return nil }
        guard let recipient = json["to"].string else { return nil }
        guard let dateString = json["date_sent"].string else { return nil }
        guard let status = json["status"].string else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        guard let date = dateFormatter.date(from: dateString) else { return nil }

        let sender: Sender = Sender(id: from, displayName: from)
        self.init(kind: .text(body), sender: sender, recipient: recipient, messageId: messageId, date: date, status: MessageStatus(rawValue: status)!)
    }
    
    func prettyDate(_ format: String? = "HH:mm") -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        
        return dateFormatterPrint.string(from: sentDate)
    }
}
