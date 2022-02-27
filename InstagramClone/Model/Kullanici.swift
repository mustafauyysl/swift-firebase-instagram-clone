//
//  Kullanici.swift
//  InstagramClone
//
//  Created by Mustafa on 25.02.2022.
//

import Foundation

struct Kullanici {
    let kullaniciAdi : String
    let kullaniciID : String
    let profilGoruntuURL : String

    init(kullaniciVerisi: [String: Any]) {
        self.kullaniciAdi = kullaniciVerisi["KullaniciAdi"] as? String ?? ""
        self.kullaniciID = kullaniciVerisi["KullaniciID"] as? String ?? ""
        self.profilGoruntuURL = kullaniciVerisi["ProfilGoruntuURL"] as? String ?? ""
    }
}
