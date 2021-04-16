//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

public typealias UIConfig = _UIConfig<NoExtraData>

public struct _UIConfig<ExtraData: ExtraDataTypes> {
    /// A view used as an online activity indicator (online/offline).
    public var onlineIndicatorView: (UIView & MaskProviding).Type = _ChatOnlineIndicatorView<ExtraData>.self

    /// A view that displays the avatar image. By default a circular image.
    public var avatarView: ChatAvatarView.Type = ChatAvatarView.self

    /// An avatar view with an online indicator.
    public var presenceAvatarView: _ChatPresenceAvatarView<ExtraData>.Type = _ChatPresenceAvatarView<ExtraData>.self

    /// A view that displays a quoted message.
    public var messageQuoteView: _ChatMessageQuoteView<ExtraData>.Type = _ChatMessageQuoteView<ExtraData>.self
    
    /// A view that is used as a wrapper for status data in navigationItem's titleView
    public var titleView: _TitleContainerView<ExtraData>.Type = _TitleContainerView<ExtraData>.self

    /// A `UIView` subclass which serves as container for `typingIndicator` and `UILabel` describing who is currently typing
    public var typingIndicatorView: _TypingIndicatorView<ExtraData>.Type = _TypingIndicatorView<ExtraData>.self
    
    /// A `UIView` subclass with animated 3 dots for indicating that user is typing.
    public var typingAnimationView: _TypingAnimationView<ExtraData>.Type = _TypingAnimationView<ExtraData>.self

    public var channelList = ChannelList()
    public var messageList = MessageListUI()
    public var messageComposer = MessageComposer()
    public var currentUser = CurrentUser()
    public var navigation = Navigation()
    public var colorPalette = ColorPalette()
    public var font = Font()
    public var images = Images()

    public init() {}
}

// MARK: - UIConfig + Default

private var defaults: [String: Any] = [:]

public extension _UIConfig {
    static var `default`: Self {
        get {
            let key = String(describing: ExtraData.self)
            if let existing = defaults[key] as? Self {
                return existing
            } else {
                let config = Self()
                defaults[key] = config
                return config
            }
        }
        set {
            let key = String(describing: ExtraData.self)
            defaults[key] = newValue
        }
    }
}
