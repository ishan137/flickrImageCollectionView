//
//  CollectionViewController.swift
//  MasterDetailTask
//
//  Created by Ishan Baboota on 15/01/17.
//  Copyright © 2017 Ishan Baboota. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FlickrImageCell"

class CollectionViewController: UICollectionViewController {

    @IBOutlet var flickrCollection: UICollectionView!
    var refreshControl = UIRefreshControl()
    var selectedImage: UIImage?
    var selectedImageTitle = ""
    var selectedImageDescription = ""
    @IBOutlet weak var greyActivityView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        greyActivityView.startAnimating()
        greyActivityView.hidesWhenStopped = true
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refreshing", for: UIControlEvents.valueChanged)
        self.collectionView?.addSubview(refreshControl)
        
        feedService{() -> () in
            DispatchQueue.main.async(execute: { () -> Void in
                self.greyActivityView.stopAnimating()
                self.flickrCollection.reloadData()
            })
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func refreshing() {
        greyActivityView.startAnimating()
        feedService{() -> () in
            DispatchQueue.main.async(execute: { () -> Void in
                self.greyActivityView.stopAnimating()
                self.flickrCollection.reloadData()
            })
        }
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return feedData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MaterCollectionCell
    
        // Configure the cell
        cell.FlickrImage.image = feedData[indexPath.row].flickrImage! as UIImage

        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = feedData[indexPath.row].flickrImage! as UIImage
        selectedImageTitle = feedData[indexPath.row].title as String
        selectedImageDescription = feedData[indexPath.row].description as String
        
        self.performSegue(withIdentifier: "ImageDetail", sender:self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImageDetail" {
            // Put the destination view controller in a variable
            let NewDetailcontroller = segue.destination as! DetailViewController
            
            // Pass the data to the destination view controller
            NewDetailcontroller.retrievedImage = selectedImage!
            NewDetailcontroller.retrievedTitle = selectedImageTitle
            NewDetailcontroller.retrievedDescription = selectedImageDescription
            
        }

    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

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
