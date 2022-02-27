//
//  KullaniciProfilController.swift
//  InstagramClone
//
//  Created by Mustafa on 22.02.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class KullaniciProfilController : UICollectionViewController {

    let paylasimHucreID = "paylasimHucreID"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        kullaniciyiGetir()
        collectionView.register(KullaniciProfilHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: paylasimHucreID)

        btnOturumKapatOlustur()
    }

    fileprivate func btnOturumKapatOlustur() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Ayarlar").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(oturumKapat))
    }

    @objc fileprivate func oturumKapat() {

        let alertController =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionOturumuKapat = UIAlertAction(title: "Oturumu Kapat", style: .destructive) { (_) in

            guard let _ = Auth.auth().currentUser?.uid else { return }
            do {
                try Auth.auth().signOut()
                let oturumAcController = OturumAcController()
                let navController = UINavigationController(rootViewController: oturumAcController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            } catch let oturumuKapatmaHatasi {
                print("Oturum Kapatılırken Hata oldu : ", oturumuKapatmaHatasi)
            }

        }
        let actionIptalEt = UIAlertAction(title: "İptal", style: .cancel, handler: nil)

        alertController.addAction(actionOturumuKapat)
        alertController.addAction(actionIptalEt)
        present(alertController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let genislik = (view.frame.width - 5) / 3
        return CGSize(width: genislik, height: genislik)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let paylasimHucre = collectionView.dequeueReusableCell(withReuseIdentifier: paylasimHucreID, for: indexPath)
        paylasimHucre.backgroundColor = .blue
        return paylasimHucre
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! KullaniciProfilHeader
        header.gecerliKullanici = gecerliKullanici
        return header
    }

    var gecerliKullanici : Kullanici?

    fileprivate func kullaniciyiGetir(){
        guard let gecerliKullaniciID = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("Kullanicilar").document(gecerliKullaniciID).getDocument { (snapshot, hata) in
            if let hata = hata {
                print("Kullanıcı Bilgileri Getirilemedi : ", hata)
                return
            }

            guard let kullaniciVerisi = snapshot?.data() else { return }
            self.gecerliKullanici = Kullanici(kullaniciVerisi: kullaniciVerisi)
            // header alanı yenilenecek
            self.collectionView.reloadData()
            //let kullaniciAdi = kullaniciVerisi["KullaniciAdi"] as? String
            self.navigationItem.title = self.gecerliKullanici?.kullaniciAdi

        }
    }
}

extension KullaniciProfilController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
