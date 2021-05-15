//
//  DetailedViewController.swift
//  NewsApp
//
//  Created by vivek shrivastwa on 15/05/21.
//

import UIKit
import SDWebImage

class DetailedViewController: UIViewController {

    var model:NewsTableViewCellViewModel?
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 5
        return label
    }()
    
    private let newsSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 15
        label.text = "abhishek"
        return label
    }()
    
    private let newsImageView:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .secondarySystemBackground
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person")
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //subviews
        view.addSubview(newsTitleLabel)
        view.addSubview(newsSubTitleLabel)
        view.addSubview(newsImageView)
        
        newsTitleLabel.text = model?.title
        newsSubTitleLabel.text = model?.subTitle
        guard let url = model?.imageURL else { return }
        newsImageView.sd_setImage(with: URL(string: "\(url)"),placeholderImage: UIImage(named: "noImage"))
    }
    
    override func viewDidLayoutSubviews() {
       
        //frames
        newsImageView.frame = CGRect(x: 10,
                                     y: view.frame.origin.y + view.safeAreaInsets.top,
                                     width: view.frame.size.width - 20,
                                     height: 300)
        
        newsTitleLabel.frame = CGRect(x: 10,
                                      y: newsImageView.frame.origin.y +
                                      newsImageView.frame.size.height + 25,
                                      width: view.frame.size.width - 20,
                                      height: 150)
        
        newsSubTitleLabel.frame = CGRect(x: 10,
                                         y: newsTitleLabel.frame.origin.y + newsTitleLabel.frame.size.height + 20,
                                         width: view.frame.size.width - 20,
                                         height: 100)
    }
}
