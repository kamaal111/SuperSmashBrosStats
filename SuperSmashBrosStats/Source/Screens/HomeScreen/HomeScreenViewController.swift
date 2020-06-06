//
//  HomeScreenViewController.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import UIKit
import SwiftUI

class HomeScreenViewController: UIHostingController<HomeScreenContentView> {

    override init(rootView: HomeScreenContentView) {
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateCharacters()
    }

    private func populateCharacters() {
        Networker.getCharacters { [weak self] result in
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let characters):
                DispatchQueue.main.async {
                    self?.rootView.viewModel.characters = characters
                }
            }
        }
    }

}
