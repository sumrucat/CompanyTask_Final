//
//  EmployeeDetailResponseModel.swift
//  CompanyTask
//
//  Created by Apple on 22/11/23.
//

import Foundation

class EmployeeDetailRequestModel: Codable {
    var appKey, tokenID, userName, projectid: String?

    enum CodingKeys: String, CodingKey {
        case appKey
        case tokenID = "tokenId"
        case userName, projectid
    }

    init(appKey: String?, tokenID: String?, userName: String?, projectid: String?) {
        self.appKey = appKey
        self.tokenID = tokenID
        self.userName = userName
        self.projectid = projectid
    }
}

class EmployeeDetailResponseModel: Codable {
    var statuscode: Int?
    var data: [Datum]?
    var message: String?

    init(statuscode: Int?, data: [Datum]?, message: String?) {
        self.statuscode = statuscode
        self.data = data
        self.message = message
    }
}

// MARK: - Datum
class Datum: Codable {
    var visaCategoryID: Int?
    var employeeID, visaRequesterName: String?
    var serviceDeskID: Int?
    var createdOn, sbu, serviceDesk, visaType: String?
    var visaSubType: String?
    var countryID: Int?
    var visaCategory, userName: String?
    var visaTypeID, requestID: Int?
    var imageURL, projectID, country: String?
    var visaSubTypeID: Int?

    enum CodingKeys: String, CodingKey {
        case visaCategoryID = "visaCategoryId"
        case employeeID = "employeeId"
        case visaRequesterName
        case serviceDeskID = "serviceDeskId"
        case createdOn, sbu, serviceDesk, visaType, visaSubType
        case countryID = "countryId"
        case visaCategory, userName
        case visaTypeID = "visaTypeId"
        case requestID = "requestId"
        case imageURL = "imageUrl"
        case projectID = "projectId"
        case country
        case visaSubTypeID = "visaSubTypeId"
    }

    init(visaCategoryID: Int?, employeeID: String?, visaRequesterName: String?, serviceDeskID: Int?, createdOn: String?, sbu: String?, serviceDesk: String?, visaType: String?, visaSubType: String?, countryID: Int?, visaCategory: String?, userName: String?, visaTypeID: Int?, requestID: Int?, imageURL: String?, projectID: String?, country: String?, visaSubTypeID: Int?) {
        self.visaCategoryID = visaCategoryID
        self.employeeID = employeeID
        self.visaRequesterName = visaRequesterName
        self.serviceDeskID = serviceDeskID
        self.createdOn = createdOn
        self.sbu = sbu
        self.serviceDesk = serviceDesk
        self.visaType = visaType
        self.visaSubType = visaSubType
        self.countryID = countryID
        self.visaCategory = visaCategory
        self.userName = userName
        self.visaTypeID = visaTypeID
        self.requestID = requestID
        self.imageURL = imageURL
        self.projectID = projectID
        self.country = country
        self.visaSubTypeID = visaSubTypeID
    }
}
