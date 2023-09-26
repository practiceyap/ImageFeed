import UIKit

final class ImagesListViewController: UIViewController {
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private var imageListServiceObserver: NSObjectProtocol?
    private var alertPresenter: AlertPresenterProtocol?
    private var presenter: ImagesListViewPresenterProtocol?
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        presenter?.updateImagesListDetails()
        alertPresenter = AlertPresenter(viewController: self)
    }
    
    private lazy var dateFormatter: DateFormatter = {
        $0.dateStyle = .long
        $0.timeStyle = .none
        $0.dateFormat = "d MMM yyyy"
        return $0
    }(DateFormatter())
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSegueIdentifier {
            guard let viewController = segue.destination as? SingleImageViewController,
                  let indexPath = sender as? IndexPath else {
                return
            }
            let image = presenter?.getLargeImageURL(indexPath: indexPath)
            viewController.largeImageURL = image
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func configure(_ presenter: ImagesListViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getPhotosCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imagesListCell = cell as? ImagesListCell else {
            print("Warning: Ошибка приведения типов")
            return UITableViewCell()
        }
        
        imagesListCell.delegate = self
        guard let presenter = presenter,
              let photo = presenter.getPhoto(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        let configuringCellStatus = imagesListCell.configCell(photoURL: photo.thumbImageURL, with: indexPath)
        imagesListCell.setIsLiked(isLiked: photo.isLiked)
        if configuringCellStatus {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return imagesListCell
    }
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.fetchPhotosNextPage(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let presenter = presenter else { return CGFloat() }
        return presenter.getCellHeight(indexPath: indexPath, tableView: tableView)
    }
}

extension ImagesListViewController: ImagesListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        presenter?.imageListCellDidTapLike(cell, indexPath: tableView.indexPath(for: cell))
    }
}

extension ImagesListViewController: ImagesListViewControllerProtocol {
    func updateTableViewAnimated(oldCount: Int, newCount: Int) {
        tableView.performBatchUpdates {
            let indexPaths = (oldCount..<newCount).map { i in
                IndexPath(row: i, section: 0)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        } completion: { _ in }
    }
    
    func updateImagesListDetails() {
        imageListServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ImagesListService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.presenter?.updateTableViewAnimated()
            }
        presenter?.updateTableViewAnimated()
    }
    
    func showError() {
        let model = AlertModelOneButton(
            title: "Что-то пошло не так.",
            message: "Попробуйте ещё раз.",
            buttonText: "Оk",
            completion: nil
        )
        alertPresenter?.showOneButton(model)
    }
}
