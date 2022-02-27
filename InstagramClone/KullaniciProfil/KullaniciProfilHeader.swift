//
//  KullaniciProfilHeader.swift
//  InstagramClone
//
//  Created by Mustafa on 25.02.2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class KullaniciProfilHeader : UICollectionViewCell {

    var gecerliKullanici : Kullanici? {
        didSet {
            guard let url = URL(string: gecerliKullanici?.profilGoruntuURL ?? "") else { return }
            imgProfilGoruntu.sd_setImage(with: url, completed: nil)
            lblKullaniciAdi.text = gecerliKullanici?.kullaniciAdi
        }
    }

    let btnProfilDuzenle : UIButton = {
        let btn = UIButton()
        btn.setTitle("Profil Düzenle", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        return btn
    }()

    let lblPaylasim : UILabel = {
        let lbl = UILabel()

        let attrText =  NSMutableAttributedString(string: "10\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])

        attrText.append(NSAttributedString(string: "Paylaşım", attributes: [.foregroundColor : UIColor.darkGray, .font : UIFont.systemFont(ofSize: 14)]))

        lbl.attributedText = attrText

        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()

    let lblTakipci : UILabel = {
        let lbl = UILabel()
        let attrText =  NSMutableAttributedString(string: "25\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])

        attrText.append(NSAttributedString(string: "Takipçi", attributes: [.foregroundColor : UIColor.darkGray, .font : UIFont.systemFont(ofSize: 14)]))

        lbl.attributedText = attrText
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()

    let lblTakipEdiyor : UILabel = {
        let lbl = UILabel()
        let attrText =  NSMutableAttributedString(string: "20\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])

        attrText.append(NSAttributedString(string: "Takip Ediyor", attributes: [.foregroundColor : UIColor.darkGray, .font : UIFont.systemFont(ofSize: 14)]))

        lbl.attributedText = attrText
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()

    let lblKullaniciAdi :  UILabel = {
        let lbl = UILabel()
        lbl.text = "Kullancı Adı"
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()

    let btnGrid: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Izgara"), for: .normal)
        return btn
    }()

    let btnListe: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Liste"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()

    let btnYerIsareti: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Yer_Isareti"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()



    let imgProfilGoruntu : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .yellow
        return img
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgProfilGoruntu)
        let goruntuBoyut : CGFloat = 90
        imgProfilGoruntu.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingLeft: 15, paddingRight: 15, height: goruntuBoyut, width: goruntuBoyut)
        imgProfilGoruntu.layer.cornerRadius = goruntuBoyut / 2
        imgProfilGoruntu.clipsToBounds = true

        toolbarOlustur()
        addSubview(lblKullaniciAdi)
        lblKullaniciAdi.anchor(top: imgProfilGoruntu.bottomAnchor, bottom: btnGrid.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeft: 15, paddingRight: 15, height: 0, width: 0)

        kullaniciDurumBilgisiGoster()

        addSubview(btnProfilDuzenle)
        btnProfilDuzenle.anchor(top: lblPaylasim.bottomAnchor, bottom: nil, leading: lblPaylasim.leadingAnchor, trailing: lblTakipEdiyor.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, height: 35, width: 0)
    }

    fileprivate func kullaniciDurumBilgisiGoster() {
        let stackView = UIStackView(arrangedSubviews: [lblPaylasim, lblTakipci, lblTakipEdiyor])
        addSubview(stackView)
        stackView.anchor(top: topAnchor, bottom: nil, leading: imgProfilGoruntu.trailingAnchor, trailing: trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 15, paddingRight: -15, height: 50, width: 0)
        stackView.distribution = .fillEqually
    }

    fileprivate func toolbarOlustur() {

        let ustAyrac = UIView()
        ustAyrac.backgroundColor = UIColor.lightGray

        let altAyrac = UIView()
        altAyrac.backgroundColor = UIColor.lightGray

        let stackView = UIStackView(arrangedSubviews: [btnGrid,btnListe, btnYerIsareti])
        addSubview(stackView)
        addSubview(ustAyrac)
        addSubview(altAyrac)
        stackView.axis = .horizontal // varsayılan zaten horizotal
        stackView.distribution = .fillEqually
        stackView.anchor(top: nil, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, height: 60, width: 0)
        ustAyrac.anchor(top: stackView.topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, height: 0.5, width: 0)
        altAyrac.anchor(top: nil, bottom: stackView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, height: 0.5, width: 0)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
