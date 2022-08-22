//
//  PresenterInterface.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

protocol PresenterInterface: AnyObject {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}

extension PresenterInterface {
    func viewDidLoad() { }
    
    func viewWillAppear(animated: Bool) { }
    
    func viewDidAppear(animated: Bool) { }
    
    func viewWillDisappear(animated: Bool) { }
    
    func viewDidDisappear(animated: Bool) { }
}

