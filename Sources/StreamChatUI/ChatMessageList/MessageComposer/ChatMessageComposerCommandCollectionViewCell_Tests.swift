//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import SnapshotTesting
@testable import StreamChat
@testable import StreamChatUI
import XCTest

class ChatMessageComposerCommandCollectionViewCell_Tests: XCTestCase {
    /// Default width for the cell.
    private let defaultCellWidth: CGFloat = 250
    
    /// Default content of the view
    private let defaultCommand = Command(name: "Default", description: "", set: "", args: "[text]")
    
    func test_updateContent_whenCommandIsRecognized_commandIconImageIsUsed() {
        var appearance = Appearance()
        appearance.images.commandIcons = [
            "yoda": TestImages.yoda.image
        ]
        appearance.images.messageComposerCommandFallback = TestImages.vader.image
        
        let view = ChatMessageComposerCommandCellView()
        view.appearance = appearance
        view.content = .init(name: "yoda", description: "", set: "", args: "[text]")
        
        view.updateContent()
        
        XCTAssertEqual(view.commandImageView.image, appearance.images.commandIcons["yoda"])
    }
    
    func test_updateContent_whenCommandIsNotRecognized_fallbackCommandImageIsUsed() {
        var appearance = Appearance()
        appearance.images.commandIcons = [
            "yoda": TestImages.yoda.image
        ]
        appearance.images.messageComposerCommandFallback = TestImages.vader.image
        
        let view = ChatMessageComposerCommandCellView()
        view.appearance = appearance
        view.content = .init(name: "R2", description: "", set: "", args: "[text]")
        
        view.updateContent()
        
        XCTAssertEqual(view.commandImageView.image, appearance.images.messageComposerCommandFallback)
    }
    
    func test_defaultAppearance() {
        let view = makeView()
        view.content = defaultCommand
        AssertSnapshot(view)
    }

    func test_appearanceCustomization_usingAppearance() {
        var appearance = Appearance()
        appearance.images.commandIcons = [
            "default": TestImages.yoda.image
        ]
        
        let view = makeView()
        view.appearance = appearance
        view.content = defaultCommand
        
        AssertSnapshot(view, variants: [.defaultLight])
    }

    func test_appearanceCustomization_usingSubclassing() {
        class TestView: ChatMessageComposerCommandCellView {
            override func setUpAppearance() {
                super.setUpAppearance()

                backgroundColor = .systemGray
                commandNameSubtitleLabel.textColor = UIColor.white
                commandNameLabel.textColor = UIColor.darkGray
            }
            
            override func setUpLayout() {
                super.setUpLayout()
                
                commandNameSubtitleLabel
                    .trailingAnchor
                    .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
                    .isActive = true
            }
        }
        
        let view = makeView(TestView.self)
        view.content = defaultCommand
        AssertSnapshot(view, variants: [.defaultLight])
    }
    
    // MARK: - Factory Helper
    
    private func makeView(_ customView: ChatMessageComposerCommandCellView.Type? = nil) -> ChatMessageComposerCommandCellView {
        let view = customView != nil ? customView!.init() : ChatMessageComposerCommandCellView()
        view.widthAnchor.constraint(equalToConstant: defaultCellWidth).isActive = true
        return view.withoutAutoresizingMaskConstraints
    }
}
