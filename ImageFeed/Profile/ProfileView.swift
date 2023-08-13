//
//  ProfileView.swift
//  ImageFeed
//
//  Created by Muller Alexander on 19.07.2023.
//

import UIKit

final class ProfileView: UIView {
    
    let profileImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView(image: UIImage(named: "photo")))
    
    let profileName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Екатерина Новикова"
        $0.font = UIFont.boldSystemFont(ofSize: 23)
        $0.textColor = .white
        $0.numberOfLines = 1
        return $0
    }(UILabel(frame: .zero))
    
    let profileLogin: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "@ekaterina_nov"
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.textColor = UIColor(red: 174/255, green: 175/255, blue: 180/255, alpha: 1)
        return $0
    }(UILabel(frame: .zero))
    
    let profileDescription: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Hello, world!"
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.textColor = .white
        return $0
    }(UILabel(frame: .zero))
    
    let logOutButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "exit"), for: .normal)
      return $0
    }(UIButton(frame: .zero))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 26/255, green: 27/255, blue: 34/255, alpha: 1)
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView {
    private func setupContraints() {
        addSubview(profileImageView)
        addSubview(profileName)
        addSubview(profileLogin)
        addSubview(profileDescription)
        addSubview(logOutButton)
        
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
            
            // Для profileLogin скорей всего тоже нужен trailing т.к отступ должен быть справа тоже на 16.
            
            profileDescription.topAnchor.constraint(equalTo: profileLogin.bottomAnchor, constant: 8),
            profileDescription.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            profileDescription.trailingAnchor.constraint(equalTo: profileLogin.trailingAnchor),
            // Для profileDescription скорей всего тоже нужен trailing т.к отступ должен быть справа тоже на 16.
            
            logOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            logOutButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
}
