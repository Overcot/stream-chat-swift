//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

extension _ChatMessageFileAttachmentListView {
    open class ItemView: _ChatMessageAttachmentInfoView<ExtraData> {
        // MARK: - Subviews

        public private(set) lazy var fileIconImageView: UIImageView = {
            let imageView = UIImageView().withoutAutoresizingMaskConstraints
            imageView.contentMode = .center
            return imageView
        }()

        // MARK: - Overrides

        override open func setUpAppearance() {
            super.setUpAppearance()
            backgroundColor = appearance.colorPalette.popoverBackground
            layer.cornerRadius = 12
            layer.masksToBounds = true
            layer.borderWidth = 1
            layer.borderColor = appearance.colorPalette.border.cgColor
        }

        override open func setUpLayout() {
            addSubview(fileIconImageView)
            addSubview(actionIconImageView)
            addSubview(fileNameAndSizeStack)

            NSLayoutConstraint.activate([
                fileIconImageView.leadingAnchor.pin(equalTo: layoutMarginsGuide.leadingAnchor),
                fileIconImageView.topAnchor.pin(equalTo: layoutMarginsGuide.topAnchor),
                fileIconImageView.bottomAnchor.pin(equalTo: layoutMarginsGuide.bottomAnchor),
                
                actionIconImageView.topAnchor.pin(equalTo: layoutMarginsGuide.topAnchor),
                actionIconImageView.trailingAnchor.pin(equalTo: layoutMarginsGuide.trailingAnchor),
                actionIconImageView.leadingAnchor.pin(
                    equalToSystemSpacingAfter: fileNameAndSizeStack.trailingAnchor,
                    multiplier: 1
                ),
                
                fileNameAndSizeStack.leadingAnchor.pin(
                    equalToSystemSpacingAfter: fileIconImageView.trailingAnchor,
                    multiplier: 2
                ),
                fileNameAndSizeStack.centerYAnchor.pin(equalTo: centerYAnchor),
                fileNameAndSizeStack.topAnchor.pin(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor),
                fileNameAndSizeStack.bottomAnchor.pin(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor)
            ])
        }

        override open func updateContent() {
            super.updateContent()

            fileIconImageView.image = fileIcon
        }

        // MARK: - Private

        private var fileIcon: UIImage? {
            guard let file = content?.attachment.file else { return nil }

            return appearance.images.fileIcons[file.type] ?? appearance.images.fileFallback
        }
    }
}
