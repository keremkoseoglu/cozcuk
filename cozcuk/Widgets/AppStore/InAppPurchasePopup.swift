//
//  InAppPurchasePopup.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 28.01.2023.
//

import StoreKit
import SpriteKit

class InAppPurchasePopup {
    private var iap     : InAppPurchaseManager
    private var scene   : SKScene
    
    public init(scene: SKScene) {
        self.scene  = scene
        self.iap    = InAppPurchaseManager.getInstance()
    }
    
    public func show() {
        self.iap.getProducts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let products): self.showInAppPurchaseAlert(product: products[0])
                case .failure(let error): self.showInAppPurchaseError(errorText: error.errorDescription ?? "?")
                }
            }
        }
    }
    
    private func showInAppPurchaseAlert(product: SKProduct) {
        guard let price = self.iap.getPriceFormatted(for: product) else { return }
        let alertController = UIAlertController(title           : "Ücretsiz hakkınız doldu!",
                                                message         : "Sınırsız ipucu / cevap hakkı ister misiniz?",
                                                preferredStyle  : .alert)
     
        alertController.addAction(
            UIAlertAction(
                title: "Evet (\(price))",
                style: .default,
                handler: { (_) in
                    
                    if !self.iap.canMakePayments {
                        self.showInAppPurchaseError(errorText: "Bu cihazda satın alma yapılamıyor.")
                        return
                    }
                    
                    self.iap.buy(product: product) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(_):
                                self.iap.purchasedFlagInDatabase = true

                            case .failure(let error):
                                self.showInAppPurchaseError(errorText: error.localizedDescription)
                            }
                        }
                    }
                }))
     
        alertController.addAction(
            UIAlertAction(
                title: "Zaten almıştım",
                style: .default,
                handler: { (_) in
                    
                    self.iap.restorePurchases { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(_):
                                self.iap.purchasedFlagInDatabase = true

                                self.showInAppPurchasePopup(title    : "Tamam",
                                                            message  : "Satın alma yüklendi, teşekkürler!")
                                
                            case .failure(let error):
                                self.showInAppPurchaseError(errorText: error.localizedDescription)
                            }
                        }
                    }
                    
                }))
        
        alertController.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        self.scene.view!.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    private func showInAppPurchaseError(errorText: String) {
        showInAppPurchasePopup(title    : "Hata",
                               message  : "Uygulama içi satın alma hatası oluştu: " + errorText)
    }
    
    private func showInAppPurchasePopup(title: String, message: String) {
        let alertController =
            UIAlertController(
                title           : title,
                message         : message,
                preferredStyle  : .alert)
     
        alertController.addAction(UIAlertAction(title: "Kapat", style: .cancel, handler: nil))
        self.scene.view!.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
