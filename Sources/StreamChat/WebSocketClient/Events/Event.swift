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

/// A protocol for any `UserEvent` where it has a `user` payload and is associated with Channel.
protocol UserChannelSpecificEvent: UserEvent {
    var cid: ChannelId { get }
}

/// A protocol for any `ChannelEvent` where it has a  `channel` payload.
protocol ChannelEvent: EventWithPayload {
    var cid: ChannelId { get }
}

/// A protocol for any `MemberEvent` where it has a `member`, and `channel` payload.
public protocol MemberEvent: Event {
    var memberUserId: UserId { get }
    var cid: ChannelId { get }
}

/// A protocol for any `MessageEvent` where it has a `user`, `channel` and `message` payloads.
protocol MessageEvent: EventWithPayload {
    var userId: UserId { get }
    var cid: ChannelId { get }
    var messageId: MessageId { get }
}

/// A protocol for any  `ReactionEvent` where it has reaction with `message`, `channel`, `user` and `reaction` payload.
protocol ReactionEvent: EventWithPayload {
    var userId: UserId { get }
    var cid: ChannelId { get }
    var reactionType: MessageReactionType { get }
    var reactionScore: Int { get }
}

/// A protocol for `TypingEvent` which contains `user`, `channel` payloads. Also differs whether it's start or stop by `isTyping` property.
protocol UserTypingEvent: EventWithPayload {
    var userId: UserId { get }
    var cid: ChannelId { get }
    var isTyping: Bool { get }
}

protocol UserNotificationEvent: EventWithPayload {
    var userId: UserId { get }
}

/// A protocol for `NotificationMutesUpdatedEvent` which contains `me` AKA `currentUser` payload.
protocol CurrentUserNotificationEvent: EventWithPayload {
    var currentUserId: UserId { get }
}

// TODO: Does it make sense to have separate `ChannelNotificationEvent` x
// `ChannelEvent` and `MessageNotificationEvent` x `MessageEvent` ??

/// A protocol for Channel-related `NotificationEvents` which contain `channel` payload
protocol ChannelNotificationEvent: EventWithPayload {
    var cid: ChannelId { get }
}

/// A protocol for recognizing invitation related events (invitation accepted, rejected, added, removed)
/// Contains `user` and `channel` payload
protocol InviteRelatedNotificationEvent: EventWithPayload {
    var userId: UserId { get }
    var cid: ChannelId { get }
}

/// A protocol for `NotificationMarkAllReadEvent`, contains only `user` payload.
protocol NotificationMarkReadAllEventProtocol: EventWithPayload {
    var userId: UserId { get }
}

/// A protocol for `NotificationMarkReadEvent`, contains `user`and `channel` payload.
protocol NotificationMarkReadEventProtocol: NotificationMarkReadAllEventProtocol {
    var cid: ChannelId { get }
}

protocol NotificationMessageEvent: MessageEvent {}

// -------------------------------------------------------

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
