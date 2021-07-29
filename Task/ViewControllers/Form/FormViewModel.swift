//
//  FormViewModel.swift
//  Task
//
//  Created by Mac_Admin on 29/07/21.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation
import CoreData

enum Epithet: String {
    case Mr
    case Mrs
}

struct FormViewState {
    let firstName: String
    let lastName: String
    let epithet: Epithet
}



struct FormViewModel {
    var data = Dynamic<FormViewState?>(nil)
    
    // Core data methods
    func saveToCodeData(state: FormViewState) {
        guard let model = CoreDataManager.shared.getFormFieldDataModel()?.first else {
            return
        }
        model.firstname = state.firstName
        model.lastname = state.lastName
        model.epithet = state.epithet.rawValue
        CoreDataManager.shared.saveContext()
    }
    
    func fetchFromCoreDate(){
        let allValues = CoreDataManager.shared.getFormFieldDataModel()
        guard let model = allValues?.first else {
            return
        }
        let state = FormViewState(firstName: model.firstname ?? "", lastName: model.lastname ?? "", epithet: Epithet(rawValue: model.epithet ?? "Mr")!)
        self.data.value = state
    }
    
    func deleteEntry() {
        let object = CoreDataManager.shared.getFormFieldDataModel()
        object?.forEach { CoreDataManager.shared.context.delete($0) }
    }
}
