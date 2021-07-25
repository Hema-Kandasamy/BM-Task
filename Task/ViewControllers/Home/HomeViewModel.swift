//
//  HomeViewModel.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// ViewState
struct HomeViewState {
    let title: String
    let customerTYype: [String]
    let status: [String]
    let appointments: [Appointment]
}

struct Appointment {
    let name: String
    let users: [UsersType]?
}
enum ServerRequestStatus: Int {
    case none
    case started
    case ended
}

class HomeViewModel {

    // MARK: Properties
    private var session: NetworksessionProtocol!
    var data = Dynamic<HomeViewState?>(nil)
    var error = Dynamic<Error?>(nil)
    var status: Dynamic<ServerRequestStatus> = Dynamic(ServerRequestStatus.none) // We can use this to load activity indicator

    // Init
    init(with session: NetworksessionProtocol) {
        self.session = session
    }

    // Fetch Data Methods
    func fetchData() {
        let request = APIRequest(resource: RootRequestResource())
        session.enqueue(networkRequest: request) { [weak self] result in
            guard let strongSelf = self else { return }

            do {
                let data = try result.get()
                let appointments = strongSelf.makeAppointmentList(with: data.appointmentType)
                let state = HomeViewState(title: data.message, customerTYype: data.customerTyoe, status: data.orderStatus, appointments: appointments)
                self?.data.value = state
                // You can use the core data manager to save and fetch required data. But here, I do not need to fetch it data as i get latest froms server
                self?.saveToCoreData()
            }
            catch {
                self?.error.value = error
            }
        }
    }
    
    private func makeAppointmentList(with list: [AppointmentType]) -> [Appointment] {
        return list.map { (value) -> Appointment in
            return Appointment(name: value.name, users: value.users)
        }
        
    }
}

// Core data methods
extension HomeViewModel {
    func saveToCoreData() {
        let task =  ContentDataModel(context: CoreDataManager.shared.context)
        let customerType = self.data.value?.customerTYype
        task.customerType = arrayToBinaryData(array: customerType)
        
        let orderStatus = self.data.value?.status
        task.orderStatus = arrayToBinaryData(array: orderStatus)
        CoreDataManager.shared.saveContext()
    }
    
    func getFromCoreData() {
        let values = CoreDataManager.shared.getAllValues()
        let value = values?.compactMap { (dataModel) -> [String] in
            let custTypeData = dataModel.customerType
            return dataToArray(data: custTypeData ?? Data())
        }
    }
    private func arrayToBinaryData<T>(array: T) -> Data {
        let array = try? NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
        return array ?? Data()
    }
    
    private func dataToArray(data: Data) -> [String] {
        let array = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: data)
        return array as? [String] ?? []
    }
    

}
