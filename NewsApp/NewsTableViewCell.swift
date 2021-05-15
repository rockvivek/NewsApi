//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by vivek shrivastwa on 15/05/21.
//

import UIKit
import SDWebImage

class NewsTableViewCellViewModel{
    let title: String
    let subTitle: String
    let imageURL: String?
    
    init(title: String, subTitle: String, imageURL: String?){
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let newsSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let newsImageView:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .secondarySystemBackground
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSubTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // adding frames
    override func layoutSubviews() {
        newsTitleLabel.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 50))
        
        newsSubTitleLabel.frame = CGRect(origin: CGPoint(x: 0, y: 50), size: CGSize(width: 300, height: 100))
        
        newsImageView.frame = CGRect(origin: CGPoint(x: 300, y: 10), size: CGSize(width: 130, height: 130))
        
    }
    
    //prepare for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //configure
    func configure(with model: NewsTableViewCellViewModel){
        newsTitleLabel.text = model.title
        newsSubTitleLabel.text = model.subTitle
        //image
        guard let url = model.imageURL else { return }
        //print(url)
        newsImageView.sd_setImage(with: URL(string: "\(url)"),placeholderImage: UIImage(named: "noImage"))
    }
    
}

