import UIKit

public protocol ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }
    func updateTableViewAnimated()
    func fetchPhotosNextPage(indexPath: IndexPath)
    func imageListCellDidTapLike(_ cell: ImagesListCell, indexPath: IndexPath?)
    func getPhotosCount() -> Int
    func getPhoto(indexPath: IndexPath) -> Photo?
    func getCellHeight(indexPath: IndexPath, tableView: UITableView) -> CGFloat
    func getLargeImageURL(indexPath: IndexPath) -> URL?
    func updateImagesListDetails()
}
