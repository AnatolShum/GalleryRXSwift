//
//  MainViewModel.swift
//  GalleryRXSwift
//
//  Created by Anatolii Shumov on 21/07/2023.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    var items = PublishSubject<[Model]>()
    var page = 1
    private var model: [Model] = []
    
    func fetchItems() {
        Task {
            do {
                let hits = try await Network.shared.fetchJSON(page: page)
                
                model.append(contentsOf: hits)
                items.onNext(model)
            } catch {
                print("Failed to fetch data")
            }
        }
    }
}
