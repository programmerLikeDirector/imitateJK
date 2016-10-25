//
//  MessageCell.swift
//  imitateJK
//
//  Created by surenano on 16/10/18.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

private let pictureCellMargin : CGFloat = 3
private let commonMargin : CGFloat = 20

private let maxWidth = ScreenWidth - 2 * commonMargin
private let itemWidth = (maxWidth - 2 * pictureCellMargin) / 3

class MessageCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var collectionView: PictureCollectionView!
    @IBOutlet weak var collectionWidth: NSLayoutConstraint!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    
    var cellModel : MessagePageCellModel? {
    
        didSet{
            title.text = cellModel?.item?.title
            
            let urlString = URL(string: (cellModel?.item?.topic?.thumbnailUrl) ?? "")
            icon.sd_setImage(with: urlString)
            
            time.text = cellModel?.item?.createdAt
            
            content.text = cellModel?.item?.content
            
            let picCount = cellModel?.item?.pictureUrls?.count ?? 0
            
            let consSize = countItemSize(count: CGFloat(picCount))
            
            collectionWidth.constant = consSize.constrantSize.width
            collectionHeight.constant = consSize.constrantSize.height
            
            collectionFlowLayout.itemSize = consSize.itemSize
            
            collectionView.pictureArry = cellModel?.item?.pictureUrls
        }
    }
    
    
    func rowHeight(model: MessagePageCellModel) -> CGFloat {
        
        self.cellModel = model
        
        self.layoutIfNeeded()
        
        let height = collectionView.frame.maxY + 15
        
        return height
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        

        self.collectionView.bounces = false
        
        collectionFlowLayout.minimumLineSpacing = pictureCellMargin
        collectionFlowLayout.minimumInteritemSpacing = pictureCellMargin
    }
    
    func countItemSize(count: CGFloat ) -> (constrantSize: CGSize,itemSize: CGSize) {
        
        if count == 0 {
            
            let size = CGSize(width: 0.1, height: 0.1)
            
            return (size,size)
        }
        
        if count == 1 {
            
            let urlString = cellModel?.item?.pictureUrls?.first?.smallPicUrl ?? ""
            
            let url = URL(string: urlString)
            
            var picimage = UIImage()
            

            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, error, _, _, _) in
                
                if error != nil {
                    SVProgressHUD.showInfo(withStatus: "网络错误")
                    return
                }
                
                picimage = image!

            })
            
            let imageSize = picimage.size
            
            let pSize = CGSize(width: ScreenWidth - 2*commonMargin, height: 200)
            
             return (pSize,imageSize.width >= ScreenWidth ? pSize : imageSize)
        }
        
        if count == 4 {
            
            let width = itemWidth * 2 + pictureCellMargin * 2
            return (CGSize(width: width, height: width),CGSize(width: itemWidth, height: itemWidth))
        }
        
        let rowCount = CGFloat((count - 1) / 3 + 1)
        let height = rowCount * itemWidth + (rowCount - 1) * pictureCellMargin - commonMargin * 2
        return (CGSize(width: maxWidth, height: height),CGSize(width: itemWidth, height: itemWidth))
    }

}
