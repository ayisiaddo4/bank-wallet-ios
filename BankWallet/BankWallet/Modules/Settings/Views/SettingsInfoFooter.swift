import UIKit
import UIExtensions
import SnapKit

class SettingsInfoFooter: UITableViewHeaderFooterView {

    let versionLabel = UILabel()
    let logoButton = RespondView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundView = UIView()
        backgroundView?.backgroundColor = .clear

        contentView.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(SettingsTheme.versionLabelTopMargin)
            maker.centerX.equalToSuperview()
        }
        versionLabel.textColor = SettingsTheme.versionColor
        versionLabel.font = SettingsTheme.versionFont
        versionLabel.text = "settings.info_title".localized

        let separatorView = UIView()
        separatorView.backgroundColor = SettingsTheme.infoFooterSeparatorColor
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(versionLabel)
            maker.top.equalTo(versionLabel.snp.bottom).offset(SettingsTheme.separatorMargin)
            maker.height.equalTo(1 / UIScreen.main.scale)
        }

        let titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(separatorView.snp.bottom).offset(SettingsTheme.infoTitleTopMargin)
            maker.centerX.equalToSuperview()
        }
        titleLabel.textColor = SettingsTheme.infoTitleColor
        titleLabel.font = SettingsTheme.infoTitleFont
        titleLabel.text = "settings.info_subtitle".localized

        let imageView: TintImageView = TintImageView(image: UIImage(named: "Logo Image"), tintColor: SettingsTheme.logoTintColor, selectedTintColor: SettingsTheme.logoSelectedTintColor)
        logoButton.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        logoButton.delegate = imageView

        contentView.addSubview(logoButton)
        logoButton.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(SettingsTheme.infoImageTopMargin)
            maker.centerX.equalToSuperview()
        }

        let topSeparatorView = UIView()
        topSeparatorView.backgroundColor = AppTheme.darkSeparatorColor
        contentView.addSubview(topSeparatorView)
        topSeparatorView.snp.makeConstraints { maker in
            maker.leading.top.trailing.equalToSuperview()
            maker.height.equalTo(1 / UIScreen.main.scale)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(appVersion: String, handleTouch: (() -> ())? = nil) {
        versionLabel.text = "settings.info_title".localized + " " + appVersion
        logoButton.handleTouch = handleTouch
    }

}
