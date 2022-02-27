//
//  FotografSeciciController.swift
//  InstagramClone
//
//  Created by Mustafa on 28.02.2022.
//

import UIKit

class FotografSeciciController : UICollectionViewController {
    let hucreID = "hucreID"
    let headerID = "headerID"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        butonlariEkle()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: hucreID)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let genislik = view.frame.width
        return CGSize(width: genislik, height: genislik)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
        header.backgroundColor = .blue
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: hucreID, for: indexPath)
        hucre.backgroundColor = .brown
        return hucre
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    fileprivate func butonlariEkle(){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "İptal Et", style: .plain, target: self, action: #selector(btnIptalPresses))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sonraki", style: .plain, target: self, action: #selector(btnSonrakiPressed))
    }

    @objc fileprivate func btnIptalPresses() {
        dismiss(animated: true, completion: nil)
    }

    @objc fileprivate func btnSonrakiPressed() {
        dismiss(animated: true, completion: nil)
    }


}

extension UINavigationController {

    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}

extension FotografSeciciController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let genislik = (view.frame.width - 3) / 4
        return CGSize(width: genislik, height: genislik)
    }
}
