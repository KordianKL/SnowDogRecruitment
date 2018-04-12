//
//  ViewModel.swift
//  iOSRecruitmentTest
//
//  Created by Kordian Ledzion on 23/03/2018.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation

class ViewModel {
    
    private let dataSource: DataSource
    private let gateway: Gateway
    private var base: [RecruitmentItem]
    private var items: [RecruitmentItem]
    
    var count: Int {
        get {
            return items.count
        }
    }
    
    init(dataSource: DataSource, gateway: Gateway) {
        self.dataSource = dataSource
        self.gateway = gateway
        base = dataSource.getAllItems()
        items = base
    }
    
    func getItem(at index: Int) -> RecruitmentItem{
        return items[index]
    }
    
    func refreshData(_ completion: @escaping () -> Void) {
        gateway.fetchAllItems { [unowned self] result in
            switch result {
            case .success(let fetchedItems):
                DispatchQueue.main.async {
                    self.dataSource.deleteAll()
                    self.dataSource.add(fetchedItems)
                    self.base = self.dataSource.getAllItems()
                    self.items = self.base
                }
            case .failure(let error):
                NSLog("Fetching error: \(error)")
                abort()
            }
            completion()
        }
    }
    
    func filterItems(for text: String, _ completion: () -> Void) {
        if text == "" {
            items = base
        } else {
            let query = text.lowercased()
            items = base.filter {
                $0.desc!.lowercased().contains(query) ||
                $0.name!.lowercased().contains(query)
            }
        }
        completion()
    }
}
