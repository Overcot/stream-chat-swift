//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import Foundation

/// An `Event` object representing an event in the chat system.
public protocol Event {}

/// An internal protocol marking the Events carrying the payload. This payload can be then used for additional work,
/// i.e. for storing the data to the database.
protocol EventWithPayload: Event {
    /// Type-erased event payload. Cast it to `EventPayload<ExtraData>` when you need to use it.
    var payload: Any { get }
}

/// A protocol for any `UserEvent` where it has a `user` payload.
protocol UserEvent: EventWithPayload {
    var userId: UserId { get }
}

/// A protocol for any `MessageEvent` where it has a `user` payload and `channel` payload.
protocol MessageEvent: EventWithPayload {
    var userId: UserId { get }
    var cid: ChannelId { get }
}

/// A protocol for user `Event` where it has a user payload.
@available(*, deprecated, message: "Delete this and use/create channel specific Event protocols")
protocol EventWithUserPayload: EventWithPayload {
    var userId: UserId { get }
}

/// A protocol for a current user `Event` where it has `me` payload.
@available(*, deprecated, message: "Delete this and use/create channel specific Event protocols")
protocol EventWithCurrentUserPayload: EventWithPayload {
    var currentUserId: UserId { get }
}

/// A protocol for channel `Event` where it has `cid` at least.
/// The combination of `EventWithChannelId` and `EventWithPayload` events required a `channel` object inside payload.
@available(*, deprecated, message: "Delete this and use/create channel specific Event protocols")
protocol EventWithChannelId: EventWithPayload {
    var cid: ChannelId { get }
}

/// A protocol for message `Event` where it has a message payload.
@available(*, deprecated, message: "Delete this and use/create channel specific Event protocols")
protocol EventWithMessagePayload: EventWithChannelId {
    var messageId: MessageId { get }
}

/// A protocol for member `Event` where it has a member object and user object.
protocol EventWithMemberPayload: EventWithPayload {
    var memberUserId: UserId { get }
}

/// A protocol for reaction `Event` where it has reacction with message payload.
protocol EventWithReactionPayload: EventWithMessagePayload {
    var reactionType: MessageReactionType { get }
    var reactionScore: Int { get }
}
