//
//  UITableView.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 29/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RealmSwift
import RxRealm

extension UITableView {
    func applyChangeset(_ changes: RealmChangeset) {
        beginUpdates()
        deleteRows(at: changes.deleted.map { IndexPath(row: $0, section: 0) }, with: .automatic)
        insertRows(at: changes.inserted.map { IndexPath(row: $0, section: 0) }, with: .automatic)
        reloadRows(at: changes.updated.map { IndexPath(row: $0, section: 0) }, with: .automatic)
        endUpdates()
    }
}
