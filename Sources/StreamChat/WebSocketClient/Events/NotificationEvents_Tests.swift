//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

@testable import StreamChat
import XCTest

class NotificationsEvents_Tests: XCTestCase {
    let eventDecoder = EventDecoder<NoExtraData>()
    
    func test_messageNew() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationMessageNew")
        let event = try eventDecoder.decode(from: json) as? NotificationMessageNewEvent
        XCTAssertEqual(event?.userId, "steep-moon-9")
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "general"))
        XCTAssertEqual(event?.messageId, "042772db-4af2-460d-beaa-1e49d1b8e3b9")
        XCTAssertEqual(event?.createdAt.description, "2020-07-21 14:47:57 +0000")
        XCTAssertEqual(event?.unreadCount, .init(channels: 3, messages: 3))
    }
    
    func test_markAllRead() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationMarkAllRead")
        let event = try eventDecoder.decode(from: json) as? NotificationMarkAllReadEvent
        XCTAssertEqual(event?.userId, "steep-moon-9")
    }
    
    func test_markRead() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationMarkRead")
        let event = try eventDecoder.decode(from: json) as? NotificationMarkReadEvent
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "general"))
        XCTAssertEqual(event?.userId, "steep-moon-9")
        XCTAssertEqual(event?.unreadCount, .init(channels: 8, messages: 55))
    }
    
    func test_channelSomeMutedChannels() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationChannelMutesUpdatedWithSomeMutedChannels")
        let event = try eventDecoder.decode(from: json) as? NotificationChannelMutesUpdatedEvent
        XCTAssertEqual(event?.userId, "luke_skywalker")
        XCTAssertEqual((event?.payload as? EventPayload<NoExtraData>)?.currentUser?.mutedChannels.isEmpty, false)
    }
    
    func test_channelNoMutedChannels() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationChannelMutesUpdatedWithNoMutedChannels")
        let event = try eventDecoder.decode(from: json) as? NotificationChannelMutesUpdatedEvent
        XCTAssertEqual(event?.userId, "luke_skywalker")
        XCTAssertEqual((event?.payload as? EventPayload<NoExtraData>)?.currentUser?.mutedChannels.isEmpty, true)
    }

    func test_addToChannel() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationAddedToChannel")
        let event = try eventDecoder.decode(from: json) as? NotificationAddedToChannelEvent
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "new_channel_5905"))
        // Check if there is existing channel object in the payload.
        XCTAssertEqual(
            (event?.payload as? EventPayload<NoExtraData>)?.channel?.cid,
            ChannelId(type: .messaging, id: "!members-hu_6SE2Rniuu3O709FqAEEtVcJxW3tWr97l_hV33a-E")
        )
    }
    
    func test_removedFromChannel() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationRemovedFromChannel")
        let event = try eventDecoder.decode(from: json) as? NotificationRemovedFromChannelEvent
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "!members-jkE22mnWM5tjzHPBurvjoVz0spuz4FULak93veyK0lY"))
    }
    
    func test_invited() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationInvited")
        let event = try eventDecoder.decode(from: json) as? NotificationInvitedEvent<NoExtraData>
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "new_channel_1394"))
        XCTAssertEqual(event?.userId, "broken-waterfall-5")
        XCTAssertEqual(event?.memberRole, .member)
    }
    
    func test_inviteAccepted() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationInviteAccepted")
        let event = try eventDecoder.decode(from: json) as? NotificationInviteAcceptedEvent<NoExtraData>
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "new_channel_6293"))
        XCTAssertEqual(event?.userId, "broken-waterfall-5")
        XCTAssertEqual(event?.memberRole, .member)
        XCTAssertEqual(event?.acceptedAt.description, "2020-07-21 15:51:53 +0000")
    }
    
    func test_inviteRejected() throws {
        let json = XCTestCase.mockData(fromFile: "NotificationInviteRejected")
        let event = try eventDecoder.decode(from: json) as? NotificationInviteRejectedEvent<NoExtraData>
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "new_channel_6293"))
        XCTAssertEqual(event?.userId, "broken-waterfall-5")
        XCTAssertEqual(event?.memberRole, .member)
        XCTAssertEqual(event?.rejectedAt.description, "2020-07-21 15:51:53 +0000")
    }
}
