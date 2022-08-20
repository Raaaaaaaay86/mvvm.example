//
//  ViewControllerViewModel.swift
//  mvvm.example
//
//  Created by 林家富 on 2022/8/20.
//

import Foundation

protocol ViewControllerData {
    var peopleList: [Person?] { get }
    var countdown: Int { get }
}

protocol ViewControllerNotifier {
    var peopleListOnChange: (([Person?]?) -> Void)? { get set }
    var countdownOnChange: ((Int) -> Void)? { get set }
    var showAlert: ((_ message: String) -> Void)? { get set }
}

protocol ViewControllerMutation {
    func decrementCountdown(_ value: Int)
    func incrementCountdown(_ value: Int)
}

protocol ViewControllerFetch {
    func fetchNewPerson()
}

protocol ViewControllerViewModelProtocol:
    ViewControllerData,
    ViewControllerNotifier,
    ViewControllerMutation,
    ViewControllerFetch {
}

class ViewControllerViewModel: ViewControllerViewModelProtocol {
    
    // MARK: Property
    var peopleList: [Person?] = []
    
    var countdown: Int = 0 {
        didSet {
            if countdown != oldValue {
                countdownOnChange?(countdown)
            }
        }
    }
    
    // MARK: Notifier
    var peopleListOnChange: (([Person?]?) -> Void)?
    
    var showAlert: ((String) -> Void)?
    
    var countdownOnChange: ((Int) -> Void)?
    
    // MARK: Mutation
    func decrementCountdown(_ value: Int) {
        if countdown == 0 {
            return
        }
        countdown -= value
    }
    
    func incrementCountdown(_ value: Int) {
        countdown += value
    }
    
    // MARK: Async API Function
    func fetchNewPerson() {
        APIManager.shared?.GET_JSON(
            API.GetRandomUser,
            responseDataType: RandomUserAPIResponse.self,
            completionBlock: { [weak self] data, response, error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    self.showAlert?(error.localizedDescription)
                    return
                }
                
                guard let personData = data?.results?[0] else {
                    self.showAlert?("NO DATA")
                    return
                }
                
                self.peopleList.append(personData)
                self.peopleListOnChange?(self.peopleList)
            }
        )
    }
}
