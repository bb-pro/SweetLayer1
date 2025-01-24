//
//  RecipesCollectionVC.swift
//  SweetLayers
//
//  Created by 1 on 17/01/25.
//

import UIKit

class RecipesCollectionVC: UIViewController {
    @IBOutlet weak var collecctionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collecctionView.dataSource = self
        collecctionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func exitTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
extension RecipesCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipieCell", for: indexPath) as! RecipieCell
        let cellWidth = (view.frame.width - 52) / 3
        let visibilityStatus = (UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.levels) as! [Int]).contains(indexPath.row + 1)
        cell.setupUI(to: cellWidth, isOpened: visibilityStatus, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let visibilityStatus = (UserDataConfiguration.shared.getValueOfKey(key: UserDataConfiguration.shared.levels) as! [Int]).contains(indexPath.row + 1)
        if visibilityStatus {
            let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeDescriptionVC") as! RecipeDescriptionVC
            vc.index = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
