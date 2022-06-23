//
//  AppDelegate.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

#warning("MAIN TODO")
/*
 DESIGN
    çözünürlüğe karar ver
    logo
 SORU BANKASI
    -> ios'a CSV gibi bir dosya nasıl yüklenebilir
    eş anlamlı kelime bankası oluştur
    eş anlamlı kelimeler
    eş anlamlı kelimeden bilmece üretme
    üretilen bilmeceleri buffer'a al, buffer'dan sor
    daha önceden sorulmuş soruları biriktir, tekrar sorma
    yeni thread'da sürekli soru üretip buffer'ı doldurma
 CEVAP KONTROLÜ
    türkçe karakter toleransı ile cevapları kontrol edebilmeliyiz
    cevabı bildiyse, buffer'dan düş ve sorulmuş sorulara ekle
 GUI
    entry screen
    müzik aç / kapa
    tutorial - hazır bilmecelerden
        kırmızıadam = alaçatı
        saçsızdoğurtucuk = kelebek
        kelyösi = kedi
        elyüt = allık
    gerçek oyun - üretilen bilmecelerden
    soru yüklenecek
    buffer'da soru yoksa "please wait" ekranı, yeterince üretsin
    soru ekrana havalı gelsin
    cevap beklerken soru kıpırdasın
    cevabı gösterme animasyonu (ters dönme vs)
    ses efektleri
    güzel background
    "bilemedim, cevabı göster" butonu
    launch screen
    node sayısına dikkat - işi biten node'ları yok et
 TEST
    iphone test
    ipad test
 SALES
    ilk X bilmece bedava, sonrası parayla gibi olsun
FINAL
    warning kalmasın
    app'taki node collision vs göstermeyi test mi değil mi haline getir
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

