//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import StreamChatUI
import UIKit

extension ChatClient {
    /// The singleton instance of `ChatClient`
    static let shared: ChatClient = {
        // Register custom UI elements
        var appearance = Appearance()
        var components = Components()
        
        components.channelList.itemView = iMessageChatChannelListItemView.self
        components.channelList.cellSeparatorReusableView = iMessageCellSeparatorView.self

        components.navigation.channelListRouter = iMessageChatChannelListRouter.self
        appearance.images.newChat = UIImage(systemName: "square.and.pencil")!
        components.messageComposer.messageComposerView = iMessageChatMessageComposerView.self
        components.messageList.defaultMessageCell = iMessageСhatMessageCollectionViewCell.self
        components.messageComposer.messageComposerViewController = iMessageChatComposerViewController.self

        Appearance.default = appearance
        Components.default = components

        let config = ChatClientConfig(apiKey: APIKey("q95x9hkbyd6p"))
        return ChatClient(
            config: config,
            tokenProvider: .static(
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiY2lsdmlhIn0.jHi2vjKoF02P9lOog0kDVhsIrGFjuWJqZelX5capR30"
            )
        )
    }()
}
