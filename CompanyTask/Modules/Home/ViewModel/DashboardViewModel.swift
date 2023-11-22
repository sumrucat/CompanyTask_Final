//
//  DashboardViewModel.swift
//  CompanyTask
//
//  Created by Apple on 22/11/23.
//

import Foundation

class DashboardViewModel {
    
    var employeeData: [Datum]?
    var error: String?
    
    func fetchEmployeeData(userName: String, completion: @escaping (Bool, String?) -> Void) {
        let request = EmployeeDetailRequestModel(appKey: APIConstants.appKey, tokenID: APIConstants.tokenID, userName: userName, projectid: APIConstants.projeectId)
        
        if let inputJSON = try? JSONEncoder().encode(request) {
            Network.shared.makePostRequest(requestData: inputJSON) { data, isSuccess, message in
                if isSuccess && data != nil {
                    do {
                        let result = try JSONDecoder().decode(EmployeeDetailResponseModel.self, from: data!)
                        self.employeeData = result.data
                        completion(true, nil)
                    } catch {
                        self.error = error.localizedDescription
                        completion(false, "Decoding Error: \(error.localizedDescription)")
                    }
                }else {
                    self.error = message
                    completion(false, message)
                }
                
            }
        }else {
            self.error = "JsonEncoderFail"
            completion(false, "JsonEncoderFail")
        }
    }
}
