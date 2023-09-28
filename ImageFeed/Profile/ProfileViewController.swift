import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {

    private let profileView = ProfileView(frame: .zero)
    private var profileImageServiceObserver: NSObjectProtocol?
    private var alertPresenter: AlertPresenterProtocol?
    private var presenter: ProfilePresenterProtocol?

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack

        profileView.didTapLogoutButton = { [weak self] in
            self?.showAlertExitProfile()
        }

        alertPresenter = AlertPresenter(viewController: self)
        presenter?.viewDidLoad()
    }

    func showAlertExitProfile() {
        let model = AlertModelTwoButton(
            title: "Пока, пока!",
            message: "Уверены что хотите выйти?",
            buttonTextOne: "Да",
            buttonTextTwo: "Нет",
            completionOne: { [weak self] in
                guard let self = self else { return }
                presenter?.exitProfile()
            },
            completionTwo: nil
        )
        alertPresenter?.showTwoButton(model)
    }

    func configure(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
}

// MARK: - ProfileViewControllerProtocol

extension ProfileViewController: ProfileViewControllerProtocol {
    func updateAvatar(imageURL: URL) {
        let processor = RoundCornerImageProcessor(cornerRadius: 60)
        profileView.getProfileImageView().kf.indicatorType = .activity
        profileView.getProfileImageView().kf.setImage(with: imageURL,
                                    placeholder: UIImage(named: "stub"),
                                    options: [.processor(processor)])
    }

    func updateProfileDetails(profile: Profile?) {
        guard let profile = profile else { return }
        profileView.getProfileName().text = profile.name
        profileView.getProfileLogin().text = profile.loginName
        profileView.getProfileDescription().text = profile.bio

        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.presenter?.updateAvatar()
            }
        presenter?.updateAvatar()
    }
}
