//
//  Petition.swift
//  WhitehousePetitions
//
//  Created by Olzhas Suleimenov on 29.07.2022.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

extension Petition {
    func lowercasePetition() -> Petition {
        let title = self.title.lowercased()
        let body = self.body.lowercased()
        let signatureCount = self.signatureCount
        
        
        let newPetition = Petition(title: title, body: body, signatureCount: signatureCount)
        return newPetition
    }
}
