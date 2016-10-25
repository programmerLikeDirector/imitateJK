//
//  PictureCollectionView.swift
//  imitateJK
//
//  Created by surenano on 16/10/19.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

private let picCellID = "picCell"

class PictureCollectionView: UICollectionView {
    
    
    var pictureArry: [PictureUrlsModel]? {
    
        didSet{
            
            reloadData()
        }
    }

    override func awakeFromNib() {
        
        self.dataSource = self
        
        self.register(picCell.self, forCellWithReuseIdentifier: picCellID)
        
    }
    
    
}

extension PictureCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pictureArry?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picCellID, for: indexPath) as! picCell
        
        cell.picUrl = self.pictureArry?[indexPath.row]
        
        return cell
    }
    
}

class picCell: UICollectionViewCell {
    
    
    var picUrl : PictureUrlsModel? {
        didSet{
            
            let urlString = URL(string: picUrl?.middlePicUrl ?? "")
            
            imageView.sd_setImage(with: urlString)
        }
    }
    
    lazy var imageView: UIImageView = {
        
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        creatSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func creatSubViews () {
    
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView.snp.edges)
        }
    }
}


