//
//  VisaDetailTableViewCell.swift
//  CompanyTask
//
//  Created by Apple on 22/11/23.
//

import UIKit

class VisaDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var employeeIDLabel: UILabel!
    
    @IBOutlet weak var visaTypeLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(data: Datum) {
        nameLabel.text = data.visaRequesterName
        employeeIDLabel.text = data.employeeID
        visaTypeLabel.text = data.visaType
        locationLabel.text = data.serviceDesk
        userNameLabel.text = data.userName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
