//
//  CollectionViewController.swift
//  ND-MemeMeV1
//
//  Created by Naif on 18/10/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit


class CollectionViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath) as! CollectionViewCell
        
        let meme: Meme = appDelegate.memes[indexPath.row]
        cell.cellImage.image = meme.memedImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "memeDetails") as! memeDetailViewController
        
        
        detailController.meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView?.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        
        let space:CGFloat = 3.0
            let dimension = (view.frame.size.width - (2 * space)) / 3.0

            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        }

        // Do any additional setup after loading the view.
    }










//
//
//
//class CCollectionViewController: UICollectionViewController {
//
//let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//
//   @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//       return appDelegate.memes.count
//   }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath) as! CollectionViewCell
//
//       let meme: Meme = appDelegate.memes[indexPath.row]
//       cell.cellImage.image = meme.memedImage
//       return cell
//   }
//
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//   }
//
//    override func viewDidAppear(_ animated: Bool) {
//       super.viewDidAppear(animated)
//       collectionView?.reloadData()
//   }
//
//    override func viewDidLoad() {
//       super.viewDidLoad()
//       collectionView.reloadData()
//
//       let space:CGFloat = 3.0
//           let dimension = (view.frame.size.width - (2 * space)) / 3.0
//
//           flowLayout.minimumInteritemSpacing = space
//           flowLayout.minimumLineSpacing = space
//           flowLayout.itemSize = CGSize(width: dimension, height: dimension)
//       }
//
//       // Do any additional setup after loading the view.
//   }
//
//
