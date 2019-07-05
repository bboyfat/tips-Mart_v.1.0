//
//  NetworkProtocol.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol: class {
    associatedtype loginModel: Codable
    func sendRequest(with params: loginModel, handler: @escaping(_ status: Bool) ->())
}
