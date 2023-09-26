import UIKit

final class SplashViewController: UIViewController {
    private let oAuth2TokenStorage = OAuth2TokenStorage()
    private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let oAuth2Service = OAuth2Service()
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    
    private var alertPresenter: AlertPresenterProtocol?
    private var authViewController: AuthViewController?
    
    private let splashScreenImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UIImageView(image: UIImage(named: "splash_screen_logo")))
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertPresenter = AlertPresenter(viewController: self)
        
        if let token = oAuth2TokenStorage.token {
            fetchProfile(token: token)
        } else {
            switchToAuthViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlack
        setupConstraints()
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        
        window.rootViewController = tabBarController
    }
    
    private func showAlertNetworkError() {
        let model = AlertModelOneButton(
            title: "Что-то пошло не так",
            message: "Не удалось войти в систему",
            buttonText: "Оk",
            completion: nil
        )
        alertPresenter?.showSplashView(model)
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
    
    private func switchToAuthViewController() {
        let authViewController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(identifier: "AuthViewController") as? AuthViewController
        authViewController?.delegate = self
        guard let authViewController = authViewController else { return }
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
    }
    
    private func fetchOAuthToken(_ code: String) {
        oAuth2Service.fetchAuthToken(code) { [weak self] result in
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
}

extension SplashViewController {
    private func setupConstraints() {
        view.addSubview(splashScreenImageView)
        
        NSLayoutConstraint.activate([
            splashScreenImageView.heightAnchor.constraint(equalToConstant: 75),
            splashScreenImageView.widthAnchor.constraint(equalToConstant: 72),
            splashScreenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashScreenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
