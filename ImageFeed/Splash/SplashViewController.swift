//
//  SplashViewController5.swift
//  ImageFeed
//
//  Created by Muller Alexander on 27.08.2023.
//

import UIKit
//import ProgressHUD

final class SplashViewController: UIViewController {
    private let oAuth2TokenStorage = OAuth2TokenStorage()
    private let showAuthViewSegueIdentifier = "ShowAuthView"
    private let oAuth2Service = OAuth2Service.shared
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    
    private var splashScreenImageView: UIImageView!
    private var alertPresenter: AlertPresenterProtocol?
    private var authViewController: AuthViewController?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertPresenter = AlertPresenter(viewController: self)
        
        if let token = oAuth2TokenStorage.token {
            fetchProfile(token: token)
        } else {
            switchToAuthViewController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlack
        creatSplashScreenImageView()
    }
    
    private func switchToTabBarController() {
        // Получаем экземпляр `Window` приложения
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        // Cоздаём экземпляр нужного контроллера из Storyboard с помощью ранее заданного идентификатора.
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        
        // Установим в `rootViewController` полученный контроллер
        window.rootViewController = tabBarController
    }
    
    private func showAlertNetworkError() {
        let model = AlertModelOneButton(
            title: "Что-то пошло не так(",
            message: "Не удалось войти в систему",
            buttonText: "Оk",
            completion: nil
        )
        alertPresenter?.showSplashView(model)
    }
    
    private func creatSplashScreenImageView() {
        let splashScreen = UIImageView(image: UIImage(named: "splash_screen_logo"))
        splashScreen.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(splashScreen)
        NSLayoutConstraint.activate([
            splashScreen.heightAnchor.constraint(equalToConstant: 75),
            splashScreen.widthAnchor.constraint(equalToConstant: 75),
            splashScreen.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashScreen.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        self.splashScreenImageView = splashScreen
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        UIBlockingProgressHUD.show()
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code)
        }
    }
    
    private func fetchOAuthToken(_ code: String) {
        oAuth2Service.fetchOAuthToken(code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                self.fetchProfile(token: token)
                UIBlockingProgressHUD.dismiss()
            case .failure:
                UIBlockingProgressHUD.dismiss()
                showAlertNetworkError()
                break
            }
        }
    }
    
    private func fetchProfile(token: String) {
        profileService.fetchProfile(token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                profileImageService.fetchProfileImageURL(token: token, username: data.username) { _ in }
                UIBlockingProgressHUD.dismiss()
                self.switchToTabBarController()
            case .failure:
                UIBlockingProgressHUD.dismiss()
                showAlertNetworkError()
                break
            }
        }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == showAuthViewSegueIdentifier {
    //            guard
    //                let navigationController = segue.destination as? UINavigationController,
    //                let viewController = navigationController.viewControllers[0] as? AuthViewController
    //            else { return }
    //            viewController.delegate = self
    //        } else {
    //            super.prepare(for: segue, sender: sender)
    //        }
    //    }
    
    private func switchToAuthViewController() {
        let authViewController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(identifier: "AuthViewController") as? AuthViewController
        authViewController?.delegate = self
        guard let authViewController = authViewController else { return }
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
    }
}
