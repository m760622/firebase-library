//
//  LibraryCollectionViewController.swift
//  LibraryApp_Firebase
//
//  Created by Anthony Whitaker on 1/13/17.
//  Copyright © 2017 Anthony Whitaker. All rights reserved.
//

import UIKit

class LibraryCollectionViewController: UICollectionViewController {
    
    var books: Array<Book> = Array<Book>()
    
    var dataService = DataService.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataService.books() { books in
            self.books = books
            self.collectionView?.reloadData()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openBook" {
            guard let  controller = segue.destination as? RootViewController else {
                print("improper controller for this segue")
                return
            }
            
            guard let book = sender as? Book else {
                print("Improper sender for this segue")
                return
            }
            
            controller.book = book
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell {
            cell.configure(book: books[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate

    
    /// Specify if the specified item should be highlighted during tracking.
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    /// Specify if the specified item should be selected.
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(books[indexPath.row].title) selected.")
        performSegue(withIdentifier: "openBook", sender: books[indexPath.row])
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
