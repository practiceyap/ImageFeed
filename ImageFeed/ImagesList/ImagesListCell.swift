//
//  File.swift
//  ImageFeed
//
//  Created by Muller Alexander on 17.07.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var myCustomImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet weak var linearGradient: UIView!
    weak var delegate: ImagesListCellDelegate?
    private let imagesListService = ImagesListService.shared
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myCustomImageView.kf.cancelDownloadTask()
    }
    @IBAction func likeButtonClicked(_ sender: Any) {
        delegate?.imageListCellDidTapLike(self)
    }
    
    func configCell(photoURL: String, with indexPath: IndexPath) -> Bool {
        gradientLayer(linearGradient)
        
        var status = false
        guard let imageURL = URL(string: photoURL) else { return status }
        let date = imagesListService.photos[indexPath.row].createdAt
        let placeholder = UIImage(named: "placeholder")
        
        myCustomImageView?.kf.indicatorType = .activity
        myCustomImageView?.kf.setImage(
            with: imageURL,
            placeholder: placeholder
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                status = true
            case .failure:
                self.myCustomImageView.image = placeholder
            }
        }
        dateLabel.text = date?.dateTimeString
        return status
    }
    
    func setIsLiked(isLiked: Bool) {
        let likeImage = UIImage(named: isLiked ? "like_button_on" : "like_button_off")
        likeButton.setImage(likeImage, for: .normal)
    }
    
    private func gradientLayer(_ view: UIView) {
        let gradientLayer = CAGradientLayer()
        let startColor: UIColor = UIColor(red: 0.26, green: 0.27, blue: 0.34, alpha: 0.00)
        let endColor: UIColor = UIColor(red: 0.26, green: 0.27, blue: 0.34, alpha: 0.20)
        let gradientColors: [CGColor] = [startColor.cgColor, endColor.cgColor]
        gradientLayer.frame = view.bounds
        gradientLayer.colors = gradientColors
        
        view.backgroundColor = UIColor.clear
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
