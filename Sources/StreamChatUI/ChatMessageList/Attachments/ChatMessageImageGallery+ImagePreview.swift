//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import Nuke
import StreamChat
import UIKit

extension _ChatMessageImageGallery {
    open class ImagePreview: _View, ThemeProvider {
        public var content: _ChatMessageAttachmentListViewData<ExtraData>.ItemData? {
            didSet { updateContentIfNeeded() }
        }
        
        private var imageTask: ImageTask? {
            didSet { oldValue?.cancel() }
        }

        // MARK: - Subviews

        public private(set) lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            return imageView.withoutAutoresizingMaskConstraints
        }()

        public private(set) lazy var loadingIndicator = components
            .messageList
            .messageContentSubviews
            .attachmentSubviews
            .loadingIndicator
            .init()
            .withoutAutoresizingMaskConstraints

        public private(set) lazy var uploadingOverlay = components
            .messageList
            .messageContentSubviews
            .attachmentSubviews
            .imageGalleryItemUploadingOverlay
            .init()
            .withoutAutoresizingMaskConstraints

        // MARK: - Overrides

        override open func setUpAppearance() {
            super.setUpAppearance()
            imageView.backgroundColor = appearance.colorPalette.background1
        }

        override open func setUp() {
            super.setUp()
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnAttachment(_:)))
            addGestureRecognizer(tapRecognizer)
        }

        override open func setUpLayout() {
            embed(imageView)
            embed(uploadingOverlay)

            addSubview(loadingIndicator)
            loadingIndicator.centerYAnchor.pin(equalTo: centerYAnchor).isActive = true
            loadingIndicator.centerXAnchor.pin(equalTo: centerXAnchor).isActive = true
        }

        override open func updateContent() {
            let attachment = content?.attachment

            if let url = attachment?.localURL ?? attachment?.imagePreviewURL ?? attachment?.imageURL {
                loadingIndicator.isVisible = true
                imageTask = loadImage(with: url, options: .shared, into: imageView, completion: { [weak self] _ in
                    self?.loadingIndicator.isVisible = false
                    self?.imageTask = nil
                })
            } else {
                loadingIndicator.isVisible = false
                imageView.image = nil
                imageTask = nil
            }

            uploadingOverlay.content = content
            uploadingOverlay.isVisible = attachment?.localState != nil
        }

        // MARK: - Actions

        @objc open func didTapOnAttachment(_ recognizer: UITapGestureRecognizer) {
            content?.didTapOnAttachment()
        }

        // MARK: - Init & Deinit

        deinit {
            imageTask?.cancel()
        }
    }
}
