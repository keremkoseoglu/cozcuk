//
//  InAppPurchase.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 28.01.2023.
//

import StoreKit

enum InAppPurchaseManagerError: Error {
    case noProductIDsFound
    case noProductsFound
    case paymentWasCancelled
    case productRequestFailed
}

extension InAppPurchaseManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noProductIDsFound: return "Herhangi bir ürün kodu bulunamadı."
        case .noProductsFound: return "Herhangi bir ürün bulunamadı."
        case .productRequestFailed: return "Şu anda ürün bulunamıyor."
        case .paymentWasCancelled: return "Ürün satın alınması iptal edildi."
        }
    }
}

class InAppPurchaseManager: NSObject, SKProductsRequestDelegate, SKRequestDelegate {
    public  static let FREE_HINT_SOLUTION_COUNT = 25
    
    public var onBuyProductHandler: ((Result<Bool, Error>) -> Void)?
    
    private static  var SINGLETON   : InAppPurchaseManager?
    private static  let PRODUCT_ID  : String = "IpucuCevap"
    private static  let DB_NAME     : String = "INAPP_PURCHASED"
    private         var db          : Database
    
    public static func getInstance() -> InAppPurchaseManager {
        if InAppPurchaseManager.SINGLETON == nil {
            InAppPurchaseManager.SINGLETON = InAppPurchaseManager()
        }
        return InAppPurchaseManager.SINGLETON!
    }
    
    public var onReceiveProductsHandler: ((Result<[SKProduct], InAppPurchaseManagerError>) -> Void)?
    
    public var freeUsageOver: Bool {
        get {
            if GameRunModeManager.getInstance().container.infiniteFreeUsage {return false}
            return self.db.getStatistic(type: .hintGiveUpClickCount).value > InAppPurchaseManager.FREE_HINT_SOLUTION_COUNT}
    }
    
    public var purchaseNeeded: Bool {
        get {
            if GameRunModeManager.getInstance().container.infiniteFreeUsage {return false}
            if !self.freeUsageOver {return false}
            if self.purchasedFlagInDatabase {return false}
            return true
        }
    }
    
    public var canMakePayments: Bool {
        get {return SKPaymentQueue.canMakePayments()}
    }
    
    public var purchasedFlagInDatabase: Bool {
        get {
            if GameRunModeManager.getInstance().container.infiniteFreeUsage {return true}
            return self.db.getBool(InAppPurchaseManager.DB_NAME)
        }
        set(newVal) {
            self.db.setBool(InAppPurchaseManager.DB_NAME, newVal)
        }
    }
    
    public func getProducts(withHandler productsReceiveHandler: @escaping (_ result: Result<[SKProduct], InAppPurchaseManagerError>) -> Void) {
        self.onReceiveProductsHandler = productsReceiveHandler
        
        let request = SKProductsRequest(productIdentifiers: [InAppPurchaseManager.PRODUCT_ID])
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products

        if products.count > 0 {
            onReceiveProductsHandler?(.success(products))
        } else {
            onReceiveProductsHandler?(.failure(.noProductsFound))
        }
    }
    
    func requestDidFinish(_ request: SKRequest) {
        return
    }
    
    public func getPriceFormatted(for product: SKProduct) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price)
    }
    
    public func startObserving() {
        SKPaymentQueue.default().add(self)
    }
    
    public func stopObserving() {
        SKPaymentQueue.default().remove(self)
    }
    
    public func buy(product: SKProduct, withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
     
        // Keep the completion handler.
        self.onBuyProductHandler = handler
    }
    
    public func restorePurchases(withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
        self.onBuyProductHandler = handler
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    private override init() {
        self.db = Database.getInstance()
        super.init()
    }
}

extension InAppPurchaseManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        transactions.forEach { (transaction) in
            switch transaction.transactionState {
            case .purchased:
                onBuyProductHandler?(.success(true))
                self.purchasedFlagInDatabase = true
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                self.purchasedFlagInDatabase = true
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                if let error = transaction.error as? SKError {
                    if error.code != .paymentCancelled {
                        onBuyProductHandler?(.failure(error))
                    } else {
                        onBuyProductHandler?(.failure(InAppPurchaseManagerError.paymentWasCancelled))
                    }
                    print("IAP Error:", error.localizedDescription)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .deferred, .purchasing: break
            @unknown default: break
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if self.purchasedFlagInDatabase {
            onBuyProductHandler?(.success(true))
        } else {
            print("IAP: No purchases to restore!")
            onBuyProductHandler?(.success(false))
        }
    }
}
