//
//  InAppPurchaseTest.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 28.01.2023.
//

import Foundation

class InAppPurchaseTest {
    
    public func execute() {
        readProducts()
    }
    
    private func readProducts() {
        let iap = InAppPurchaseManager.getInstance()
     
        iap.getProducts { (result) in
     
            DispatchQueue.main.async {
     
                switch result {
                case .success(let products): print(products)
                case .failure(let error): print(error)
                }
            }
        }
    }
}
