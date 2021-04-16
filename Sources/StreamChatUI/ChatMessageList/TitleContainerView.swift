//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

/// A view that is used as a wrapper for status data in navigationItem's titleView
public typealias TitleContainerView = _TitleContainerView<NoExtraData>

/// A view that is used as a wrapper for status data in navigationItem's titleView
open class _TitleContainerView<ExtraData: ExtraDataTypes>: _View, UIConfigProvider {
    /// Content of the view that contains title (first line) and subtitle (second nil)
    open var content: (title: String?, subtitle: String?) = (nil, nil) {
        didSet {
            updateContentIfNeeded()
        }
    }
    
    /// Label that represents the first line of the final titleView
    open private(set) lazy var titleLabel: UILabel = UILabel()
    
    /// Label that represents the second line of the final titleView
    open private(set) lazy var subtitleLabel: UILabel = UILabel()
    
    /// A view that acts as the main container for the subviews
    open private(set) lazy var containerView: ContainerStackView = ContainerStackView()
        .withoutAutoresizingMaskConstraints
    
    override public func defaultAppearance() {
        super.defaultAppearance()
        
        titleLabel.textAlignment = .center
        titleLabel.font = uiConfig.font.headlineBold
        
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = uiConfig.font.caption1
        subtitleLabel.textColor = uiConfig.colorPalette.subtitleText
    }
    
    override open func setUp() {
        super.setUp()
        
        containerView.axis = .vertical
        containerView.alignment = .center
        containerView.spacing = 0
    }
    
    override open func setUpLayout() {
        super.setUpLayout()
        
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(subtitleLabel)
        addSubview(containerView)
        containerView.pin(to: self)
    }
    
    override open func updateContent() {
        super.updateContent()
        
        titleLabel.isHidden = content.title == nil
        titleLabel.text = content.title
        
        subtitleLabel.isHidden = content.subtitle == nil
        subtitleLabel.text = content.subtitle
    }
}
