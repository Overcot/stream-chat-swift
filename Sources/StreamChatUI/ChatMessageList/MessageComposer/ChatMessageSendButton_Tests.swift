//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import StreamChatTestTools
@testable import StreamChatUI
import SwiftUI
import XCTest

class ChatMessageSendButton_Tests: XCTestCase {
    private lazy var container = UIView().withoutAutoresizingMaskConstraints

    override func setUp() {
        super.setUp()
        container.subviews.forEach { $0.removeFromSuperview() }
    }

    func test_defaultAppearance() {
        let view = ChatMessageSendButton().withoutAutoresizingMaskConstraints
        container.embed(view)

        view.isEnabled = true
        AssertSnapshot(container, variants: .onlyUserInterfaceStyles, suffix: "new-enabled")

        view.isEnabled = false
        AssertSnapshot(container, variants: .onlyUserInterfaceStyles, suffix: "new-disabled")
    }

    func test_appearanceCustomization_usingAppearance() {
        var appearance = Appearance()
        appearance.images.messageComposerSendMessage = TestImages.vader.image.tinted(with: .systemPink)!
        appearance.colorPalette.inactiveTint = .black

        let view = ChatMessageSendButton().withoutAutoresizingMaskConstraints
        view.appearance = appearance

        container.embed(view)

        view.isEnabled = true
        AssertSnapshot(container, variants: .onlyUserInterfaceStyles, suffix: "new-enabled")

        view.isEnabled = false
        AssertSnapshot(container, variants: .onlyUserInterfaceStyles, suffix: "new-disabled")
    }

    func test_appearanceCustomization_usingSubclassing() {
        class TestView: ChatMessageSendButton {
            override func setUpLayout() {
                setTitle("🥪", for: .normal)
                setTitle("🤷🏻‍♂️", for: .disabled)
            }
        }

        let view = TestView().withoutAutoresizingMaskConstraints

        container.embed(view)
        view.isEnabled = true
        AssertSnapshot(container, variants: .onlyUserInterfaceStyles, suffix: "new-enabled")

        view.isEnabled = false
        AssertSnapshot(container, variants: .onlyUserInterfaceStyles, suffix: "new-disabled")
    }
}
