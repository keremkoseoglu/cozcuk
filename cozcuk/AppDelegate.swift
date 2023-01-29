//
//  AppDelegate.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

#warning("MAIN TODO") 
/*
 FAZ 5
    yardım bölümündeki kedi kelimesi patlıyor, dikkat et
 İÇERİK
    gerçek sözlük yükle (daha geniş)
    wordencodertest: sözlükten geniş geniş test yapsın
 TEST
    ipad test
    farklı beta tester'lar (TestFlight uygulaması var apple'ın)
 FINAL
    warning kalmasın
 YAYIN
    küfür içerebilir, ya 18+ yap ya da küfürleri sil
    app store connect tamamla - https://appstoreconnect.apple.com/apps/1666825486/appstore/ios/version/inflight
 YAYIN SONRASI
    web sitesine app store linki ekle
    kendi kaynaklarına ekle
        kendi web ana sayfana ekle
        cv
        linkedin
        bio
    promotion - https://appstoreconnect.apple.com/apps/1666825486/appstore/promotions
    instagram vs reklamı
 BACKLOG
    game center desteği
    ingilizce versiyon
    apple custom product page
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // SynonymDatabaseTest().testWord(word: "AR", expectedResult: "UTANMA"); exit(0);
       // WordEncoderTest().execute(); exit(0);
        
        InAppPurchaseManager.getInstance().startObserving()
        
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
    
    func applicationWillTerminate(_ application: UIApplication) {
        InAppPurchaseManager.getInstance().stopObserving()
    }


}

