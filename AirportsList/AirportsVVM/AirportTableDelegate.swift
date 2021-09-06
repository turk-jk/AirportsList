//
//  AirportTableDelegate.swift
//  AirportsList
//
//  Created by Yacob Kazal on 6/9/21.
//

import Foundation

protocol AirportTableDelegate: AnyObject{
    func reload()
    func showLoading()
    func showError(title:String, message: String)
}
