//
//  UICollectionView+Ext.swift
//  VKApp
//
//  Created by Ksenia Volkova on 26.04.2021.
//

import UIKit

extension UICollectionView {
    func apply(deletions: [Int] = [], insertions: [Int] = [], modifications: [Int] = []) {
        performBatchUpdates {
            let deletions = deletions.map { IndexPath(item: $0, section: 0) }
            deleteItems(at: deletions)
            let insertions = insertions.map { IndexPath(item: $0, section: 0) }
            insertItems(at: insertions)
            let modifications = modifications.map { IndexPath(item: $0, section: 0) }
            reloadItems(at: modifications)
        }
    }
}
