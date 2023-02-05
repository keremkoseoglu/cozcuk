//
//  AppDelegate.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

#warning("feedbacks") /*
OYUN
    İpucu 9 kelime ekranda asılı kalabilir
YARDIM
    oyun doğrudan yardım bölümüyle açılsın
    bir kez yardımla açıldıysa, artık bir daha yardımla açılmasın
    yardım bölümü daha net olsun
        aşağıdaki senaryoları içerecek şekilde tasarla
            ters dönme mantığı anlaşılmamış
            cevabın her zaman tek kelime olduğu net söylensin
            eş anlamlı değil, yakın anlamlı kelime diyelim
            tam bir ekran gösterip, orada ipucu ve cevapları göstermek?
            ses butonu ile ses açıp kapatmayı da göster
        tasarımı uygula
IN-APP PURCHASE
    başta kolay başlasın, biraz sarsın, sonra ipucuna ihtiyaç duyacak kadar (biraz) zorlaşsın ve bam 5 lira iste
    satın almamış biri için test: İpucu hakkım bitti. Zaten almıştıma bastım  tekrar verdi. Beta olduğu için mi
DEPLOY
    başka feedback var mı?
    warning kalmasın
    yeni versiyon yolla
    feedback iste
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

