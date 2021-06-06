//
//  CustomSearchBar.swift
//  VKApp
//
//  Created by Ksusha on 11.03.2021.
//

import UIKit

class CustomSearchBar: UISearchBar {

    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        for (i, subview) in searchBarView.subviews.enumerated() {
            if subview.isKind(of: UITextField.self) {
                index = i
                break
            }
        }
        return index
    }


    override func draw(_ rect: CGRect) {
       //Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubviews() {
           //Access the search field
            let searchField: UITextField = subviews[0].subviews[index] as! UITextField
           //Set its frame.
            searchField.frame = CGRect(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10)
           //Set the font and text color of the search field.
            searchField.font = UIFont.boldSystemFont(ofSize: 16)
            searchField.textColor = UIColor.systemRed

           //Set the placeholder and its color
            let attributesDictionary = [NSAttributedString.Key.foregroundColor: UIColor.systemGray.cgColor]
            searchField.attributedPlaceholder = NSAttributedString(string: "SearchBarPlaceholder", attributes: attributesDictionary)

           //Set the background color of the search field.
            searchField.backgroundColor = barTintColor
        }

        super.draw(rect)
    }

}
