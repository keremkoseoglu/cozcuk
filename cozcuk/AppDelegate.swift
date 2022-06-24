//
//  AppDelegate.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

#warning("MAIN TODO")
/*
 DESIGN
    logo
 GUI
    apple guideline'ları oku
    entry screen
    müzik aç / kapa
    tutorial - hazır bilmecelerden
        kırmızıadam = alaçatı
        saçsızdoğurtucuk = kelebek
        kelyösi = kedi
        elyüt = allık
    gerçek oyun - üretilen bilmecelerden
    soru yüklenecek (PuzzleQueue)
    buffer'da soru yoksa "please wait" ekranı, yeterince üretsin
    soru ekrana havalı gelsin
    uzun soruların ekrana sığacağından emin ol
    cevap beklerken soru kıpırdasın
    ipucu - Puzzle'daki component'lere göre kelimeleri ayır
    kullanıcı cevap girebilecek
    cevap kontrolü (AnswerChecker)
    cevabı gösterme animasyonu (ters dönme vs)
    ses efektleri
    güzel background
    "bilemedim, cevabı göster" butonu
    launch screen
    node sayısına dikkat - işi biten node'ları yok et
 İÇERİK
    gerçek sözlük yükle
    gerçek eş anlamlı kelimeleri yükle
    wordencodertest: sözlükten geniş geniş test yapsın
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
        // AnswerCheckerTest().execute(); exit(0);
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

