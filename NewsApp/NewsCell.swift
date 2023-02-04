//
//  NewsCell.swift
//  NewsApp
//
//  Created by Alexander Zub on 04.02.2023.
//

import UIKit

class NewsCellViewModel {
    
    let title: String
    let subtitle: String
    let imageURl: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURl: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURl = imageURl
    }
}

class NewsCell: UITableViewCell {
    
    static let identifier = "NewsCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 170, height: 70)
        subtitleLabel.frame = CGRect(x: 10, y: 70, width: contentView.frame.size.width - 170, height: contentView.frame.size.height/2)
        newsImageView.frame = CGRect(x: contentView.frame.size.width-150, y: 5, width: 150, height: contentView.frame.size.height - 10)
    }
    
    override func prepareForReuse() {
        self.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsCellViewModel) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
