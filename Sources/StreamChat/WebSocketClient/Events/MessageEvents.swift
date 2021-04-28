//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import Foundation

public struct MessageNewEvent: MessageEvent {
    public let userId: UserId
    public let cid: ChannelId
    public let messageId: MessageId
    public let createdAt: Date
    public let watcherCount: Int?
    public let unreadCount: UnreadCount?
    
    let payload: Any
    
    init<ExtraData: ExtraDataTypes>(from response: EventPayload<ExtraData>) throws {
        userId = try response.value(at: \.user?.id)
        cid = try response.value(at: \.cid)
        messageId = try response.value(at: \.message?.id)
        createdAt = try response.value(at: \.message?.createdAt)
        watcherCount = try? response.value(at: \.watcherCount)
        unreadCount = try? response.value(at: \.unreadCount)
        payload = response
    }
}

public struct MessageUpdatedEvent: MessageEvent {
    public let userId: UserId
    public let cid: ChannelId
    public let messageId: MessageId
    public let updatedAt: Date
    
    let payload: Any
    
    init<ExtraData: ExtraDataTypes>(from response: EventPayload<ExtraData>) throws {
        userId = try response.value(at: \.user?.id)
        cid = try response.value(at: \.cid)
        messageId = try response.value(at: \.message?.id)
        updatedAt = try response.value(at: \.message?.updatedAt)
        payload = response
    }
}

public struct MessageDeletedEvent: MessageEvent {
    public let userId: UserId
    public let cid: ChannelId
    public let messageId: MessageId
    public let deletedAt: Date
    
    let payload: Any
    
    init<ExtraData: ExtraDataTypes>(from response: EventPayload<ExtraData>) throws {
        userId = try response.value(at: \.user?.id)
        cid = try response.value(at: \.cid)
        messageId = try response.value(at: \.message?.id)
        deletedAt = try response.value(at: \.message?.deletedAt)
        payload = response
    }
}

// TODO: MessageReadEvent doesn't have message Id????
public struct MessageReadEvent: EventWithChannelId {
    public let userId: UserId
    public let cid: ChannelId
    public let readAt: Date
    public let unreadCount: UnreadCount?
    
    let payload: Any
    
    init<ExtraData: ExtraDataTypes>(from response: EventPayload<ExtraData>) throws {
        userId = try response.value(at: \.user?.id)
        cid = try response.value(at: \.cid)
        readAt = try response.value(at: \.createdAt)
        unreadCount = try? response.value(at: \.unreadCount)
        payload = response
    }
}
