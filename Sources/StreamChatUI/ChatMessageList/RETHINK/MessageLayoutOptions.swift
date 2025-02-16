//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import Foundation

/// Describes the layout of base message content view.
public struct MessageLayoutOptions: OptionSet, Hashable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public extension MessageLayoutOptions {
    /// If set all the content will have trailing alignment. By default, the message sent by the current user is flipped.
    static let flipped = Self(rawValue: 1 << 0)

    /// If set the message content will be wrapped into a bubble.
    static let bubble = Self(rawValue: 1 << 1)

    /// If set the message bubble will not have a `tail` (rendered by default as a non rounded corner)
    static let continuousBubble = Self(rawValue: 1 << 2)

    /// If set the message content will have an offset (from the `trailing` edge if `flipped` is set otherwise from `leading`)
    /// equal to the avatar size.
    static let avatarSizePadding = Self(rawValue: 1 << 3)

    /// If set the message author avatar will be shown.
    static let avatar = Self(rawValue: 1 << 4)

    /// If set the message metadata (timestamp, author name, etc.) will be shown.
    static let metadata = Self(rawValue: 1 << 5)

    /// If set the message author name will be shown in metadata.
    static let authorName = Self(rawValue: 1 << 6)

    /// If set the message text content will be shown.
    static let text = Self(rawValue: 1 << 7)

    /// If set the message quoted by the current message will be shown.
    static let quotedMessage = Self(rawValue: 1 << 8)

    /// If set the message thread replies information will be shown.
    static let threadInfo = Self(rawValue: 1 << 9)

    /// If set the error indicator will be shown.
    static let errorIndicator = Self(rawValue: 1 << 10)

    /// If set the reactions added to the message will be shown.
    static let reactions = Self(rawValue: 1 << 11)

    /// If set the indicator saying that the message is visible for current user only will be shown.
    static let onlyVisibleForYouIndicator = Self(rawValue: 1 << 12)
}

extension MessageLayoutOptions: CustomStringConvertible {
    /// Returns all options the current option set consists of separated by `-` character.
    public var description: String {
        Self.singleOptions
            .compactMap { contains($0) ? $0.optionName : nil }
            .joined(separator: "-")
    }

    static let singleOptions: [Self] = [
        .flipped,
        .bubble,
        .continuousBubble,
        .avatarSizePadding,
        .avatar,
        .metadata,
        .authorName,
        .text,
        .quotedMessage,
        .threadInfo,
        .errorIndicator,
        .reactions,
        .onlyVisibleForYouIndicator
    ]

    var optionName: String? {
        switch self {
        case .flipped:
            return "flipped"
        case .bubble:
            return "bubble"
        case .continuousBubble:
            return "continuousBubble"
        case .avatarSizePadding:
            return "avatarSizePadding"
        case .avatar:
            return "avatar"
        case .metadata:
            return "metadata"
        case .authorName:
            return "authorName"
        case .text:
            return "text"
        case .quotedMessage:
            return "quotedMessage"
        case .threadInfo:
            return "threadInfo"
        case .errorIndicator:
            return "errorIndicator"
        case .reactions:
            return "reactions"
        case .onlyVisibleForYouIndicator:
            return "onlyVisibleForYouIndicator"
        default:
            return nil
        }
    }
}
