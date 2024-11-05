//
//  CustomLayout.swift
//  PresentAndPhotosTestApp
//
//  Created by Asya Checkanar on 05.11.2024.
//

import UIKit

protocol CustomLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class CustomLayout: UICollectionViewFlowLayout {
    weak var delegate: CustomLayoutDelegate?
    private let columnNumber = 2
    private let padding: CGFloat = 6
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var height: CGFloat = 0
    
    private var width: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }
        let columnWidth = width / CGFloat(columnNumber)
        var xOffset: [CGFloat] = []
        for column in 0..<columnNumber {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: columnNumber)
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? 100
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: photoHeight)
            let insetFrame = frame.insetBy(dx: padding, dy: padding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            height = max(height, frame.maxY)
            yOffset[column] = yOffset[column] + photoHeight
            
            column = column < (columnNumber - 1) ? (column + 1) : 0
        }
    }
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
}
