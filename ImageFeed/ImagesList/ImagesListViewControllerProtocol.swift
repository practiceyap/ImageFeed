import UIKit

public protocol ImagesListViewControllerProtocol: AnyObject {
    func updateTableViewAnimated(oldCount: Int, newCount: Int)
    func showError()
    func updateImagesListDetails()
}
