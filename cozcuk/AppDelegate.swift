//
//  AppDelegate.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

#warning("feedbacks") /*
IN-APP PURCHASE
    puzzlequeue.swift
    questionqueue sayesinde: başta kolay başlasın, biraz sarsın, sonra ipucuna ihtiyaç duyacak kadar (biraz) zorlaşsın ve bam 5 lira iste
        bilmeceleri genel olarak da üst üste random verme. kolay / orta / zor dengesi olsun. başta kolay olabilir. level atladıkça zor oranı artabilir.
    random'a geçiş gradual olabilir. ilk 10 %100 kolay. ikinci 10 %80 kolay. üçüncü 10 %50 kolay gibi.
    satın almamış biri için test: İpucu hakkım bitti. Zaten almıştıma bastım  tekrar verdi. Beta olduğu için mi
YARDIM
    oyun doğrudan yardım bölümüyle açılsın
    bir kez yardımla açıldıysa, artık bir daha yardımla açılmasın
    yardım bölümü daha net olsun
        aşağıdaki senaryoları içerecek şekilde tasarla
            Birkaç popüler kelime oyunu indirsen örnek olması açısından faydalı olabilir
            ters dönme mantığı anlaşılmamış
            cevabın her zaman tek kelime olduğu net söylensin
            eş anlamlı değil, yakın anlamlı kelime diyelim
            tam bir ekran gösterip, orada ipucu ve cevapları göstermek?
            ses butonu ile ses açıp kapatmayı da göster
            yardım bölümünde, senin dediğin gibi, doğrudan oyun ekranı açıp simüle ederek anlatabilirim aslında iyi fikir
            puan sistemi
        tasarımı uygula
DEPLOY
    başka feedback var mı?
    warning kalmasın
    yeni versiyon yolla
    tester olarak ahu ve selin'i ekle
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

