//
//  RefreshProtocol.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

protocol RefreshServiceProtocol {
    var accessToken: String {get set}
    func sendRequest(handler: @escaping (Bool) -> ())
}
