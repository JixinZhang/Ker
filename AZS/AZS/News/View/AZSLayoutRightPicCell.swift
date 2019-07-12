//
//  AZSLayoutRightPicCell.swift
//  AZS
//
//  Created by zjixin on 2019/7/10.
//  Copyright © 2019 zjixin. All rights reserved.
//

import UIKit

class AZSLayoutRightPicCell: UITableViewCell {
    
    public var titleLabel: UILabel!
    public var sourceLabel: UILabel!
//    public var infoLabel: UILabel!
    public var contentImageView: UIImageView!
    public var closeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel.init()
        titleLabel.font = .systemFont(ofSize: 19)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-140)
            make.height.equalTo(75)
        }
        
        contentImageView = UIImageView.init()
        contentImageView.contentMode = .scaleAspectFill
        contentImageView.image = UIImage.init(named: "not_found_loading_226x119_")
        self.contentView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-15)
            make.left.equalTo(titleLabel.snp.right).offset(12)
            make.height.equalTo(75)
        }
        
        sourceLabel = UILabel.init()
        sourceLabel.font = .systemFont(ofSize: 12)
        sourceLabel.textColor = .gray
        sourceLabel.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(sourceLabel)
        sourceLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(14)
        }
    }
    
    public func configCell(model: AZSNewsInfoModel) {
        titleLabel.text = model.title
        sourceLabel.text = model.media_name ?? "" + "\(String(describing: model.read_count))阅读"
        let image = UIImage.init(named: "not_found_loading_226x119_")
        if let imageModel = model.image_list?.first {
            let imageURLString = imageModel.url
            if (imageURLString != nil) {
                let imageURL = URL.init(string: imageURLString!)!
                contentImageView.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: image, options: [KingfisherOptionsInfoItem.cacheOriginalImage], progressBlock: ({(_ receivedSize: Int64, _ totalSize: Int64) in
                    
                }),
                                             completionHandler: {[weak self](_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) in
                                                DispatchQueue.main.async {
                                                    self?.contentImageView.image = image
                                                }
                })
            } else {
                contentImageView.image = image
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
