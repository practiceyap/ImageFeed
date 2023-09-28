import UIKit

final class ProfileView: UIView {
    
    var didTapLogoutButton: (() -> Void)?
    
    private lazy var profileImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = $0.frame.size.width / 2
        $0.clipsToBounds = true
        return $0
    }(UIImageView(image: UIImage(named: "user")))
    
    private lazy var profileName: UILabel = {
        $0.text = "Екатерина Новикова"
        $0.font = UIFont.boldSystemFont(ofSize: 23)
        $0.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        $0.numberOfLines = 1
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var profileLogin: UILabel = {
        $0.text = "@ekaterina_nov"
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.textColor = UIColor(red: 174/255, green: 175/255, blue: 180/255, alpha: 1)
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var profileDescription: UILabel = {
        $0.text = "Hello, world!"
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var logOutButton: UIButton = {
        $0.tintColor = UIColor.ypRed
        $0.accessibilityIdentifier = "logoutButton"
        let image = UIImage(named: "ipad.and.arrow.forward")
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(handleLogoutButton), for: .touchUpInside)
      return $0
    }(UIButton(type: .custom))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 26/255, green: 27/255, blue: 34/255, alpha: 1)
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func handleLogoutButton() {
        didTapLogoutButton?()
    }
    
    func getProfileImageView() -> UIImageView {
        return profileImageView
    }
    
    func getProfileName() -> UILabel {
        return profileName
    }
    
    func getProfileLogin() -> UILabel {
        return profileLogin
    }
    
    func getProfileDescription() -> UILabel {
        return profileDescription
    }
    
    
}

extension ProfileView {
    private func setupContraints() {
        [profileImageView, profileName, profileLogin, profileDescription, logOutButton
                ].forEach {
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    addSubview($0)
                }
        
        // Провести проверку по корректности лейблов (profileLogin, profileDescription) - trailing нужен ли для них или нет.
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            
            profileName.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            profileName.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
             // Чтобы был отступ справа если будет к примеру такое имя: Константин Константинопольский
            profileName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            profileLogin.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 8),
            profileLogin.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            profileLogin.trailingAnchor.constraint(equalTo: profileName.trailingAnchor),
            
            profileDescription.topAnchor.constraint(equalTo: profileLogin.bottomAnchor, constant: 8),
            profileDescription.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            profileDescription.trailingAnchor.constraint(equalTo: profileLogin.trailingAnchor),
            
            logOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            logOutButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
}
